function geoip --description 'Look up public IP geolocation with IP.SB'
    argparse --name=geoip --max-args=1 --exclusive=4,6 \
        h/help j/json 4/ipv4 6/ipv6 -- $argv
    or return 2

    if set -q _flag_help
        printf '%s\n' \
            'Usage: geoip [-j|--json] [-4|--ipv4 | -6|--ipv6] [IP]' \
            '  No IP: look up the public IP used by this request.' \
            '  -j, --json   Print the full formatted GeoIP JSON response.' \
            '  -4, --ipv4   Use the IPv4 endpoint.' \
            '  -6, --ipv6   Use the IPv6 endpoint.' \
            'Uses the current curl proxy settings; requires curl and jq.'
        return 0
    end

    for dependency in curl jq
        if not command -sq $dependency
            printf 'geoip: required command not found: %s\n' $dependency >&2
            return 127
        end
    end

    set -l endpoint https://api.ip.sb/geoip
    set -l curl_options
    if set -q _flag_ipv4
        set endpoint https://api-ipv4.ip.sb/geoip
        set curl_options --ipv4
    else if set -q _flag_ipv6
        set endpoint https://api-ipv6.ip.sb/geoip
        set curl_options --ipv6
    end

    if set -q argv[1]
        # Reject paths/options; the API validates the address itself.
        if not string match -rq -- '^([0-9]{1,3}\.){3}[0-9]{1,3}$|^[0-9a-fA-F:.]*:[0-9a-fA-F:.]+$' "$argv[1]"
            printf 'geoip: expected an IPv4 or IPv6 address: %s\n' "$argv[1]" >&2
            return 2
        end
        set endpoint "$endpoint/$argv[1]"
    end

    # A custom User-Agent is recommended by https://ip.sb/api/.
    set -l response (command curl --fail --silent --show-error \
        --connect-timeout 5 --max-time 15 --user-agent fish-geoip/1.0 \
        --header 'Accept: application/json' $curl_options --url "$endpoint")
    set -l curl_status $status
    if test $curl_status -ne 0
        return $curl_status
    end

    if not printf '%s\n' $response | command jq --exit-status --slurp \
            'length == 1 and (.[0] | type == "object" and (.ip | type == "string" and length > 0))' >/dev/null 2>&1
        printf 'geoip: IP.SB returned an invalid GeoIP JSON response.\n' >&2
        return 1
    end

    if set -q _flag_json
        printf '%s\n' $response | command jq .
    else
        printf '%s\n' $response | command jq --raw-output '
            def available: if . == null or . == "" then "-" else tostring end;
            "IP:       \(.ip)",
            "Location: \([.country, .region, .city] | map(select(. != null and . != "")) | join(" / ") | available)",
            "ISP:      \((.isp // .organization) | available)",
            "ASN:      \(if .asn == null then "-" else "AS\(.asn)" end) (\(.asn_organization | available))",
            "Timezone: \(.timezone | available)",
            "Lat/Lon:  \(.latitude | available), \(.longitude | available)"
        '
    end
end
