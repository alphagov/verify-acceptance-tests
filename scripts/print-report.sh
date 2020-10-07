#!/usr/local/bin/bash

pretty_print_countries() {
  local failed_tests=($(cat $1))
  local failed_countries=($(for test in ${failed_tests[@]}; do [[ $test =~ ^.*\/(.*)\.feature:.*$ ]] && echo ${BASH_REMATCH[1]}; done))
  local country_names=${failed_countries[@]^}
  echo ${country_names// /, }
}

[[ -z "$1" ]] && echo "Environment not set" && exit 1

ENVIRONMENT="$1"

pn_countries=($(pretty_print_countries proxy-node-report-"$ENVIRONMENT"/failed-tests))
cn_countries=($(pretty_print_countries connector-node-report-"$ENVIRONMENT"/failed-tests))

num_failed_pn=${#pn_countries[@]}
num_failed_cn=${#cn_countries[@]}
[[ $num_failed_pn -eq 0 && $num_failed_cn -eq 0 ]] && exit 0

echo "There are $num_failed_pn PN and $num_failed_cn CN broken connections with eIDAS countries in $ENVIRONMENT"
[[ $num_failed_pn -gt 0 ]] && echo "Failed Proxy Node countries: ${pn_countries[@]}"
[[ $num_failed_cn -gt 0 ]] && echo "Failed Connector Node countries: ${cn_countries[@]}"

cat <<json >message
{'blocks': [
    {'type': 'section',
     'text': {'type': 'mrkdwn', 'text': 'There are broken connections with eIDAS countries in *$ENVIRONMENT* :flag-eu::broken_heart:'}},
    {'type': 'context', 'elements': [{'type': 'mrkdwn', 'text': '$num_failed_pn Proxy Node | $num_failed_cn Connector Node'}]},
    {'type': 'divider'},
    {'type': 'section',
     'fields': [$([[ $num_failed_pn -gt 0 ]] && echo "{'type': 'mrkdwn','text': '*Failed Proxy Node countries*\\n${pn_countries[@]}'},")
                $([[ $num_failed_cn -gt 0 ]] && echo "{'type': 'mrkdwn', 'text': '*Failed Connector Node countries*\\n${cn_countries[@]}'}")]},
    {'type': 'divider'},
    {'type': 'section', 'text': {'type': 'mrkdwn', 'text': 'See the status of all countries'},
     'accessory': {'type': 'button', 'text': {'type': 'plain_text', 'text': ':concourse: Go to Concourse', 'emoji': true},
                   'url': 'https://cd.gds-reliability.engineering/teams/verify/pipelines/smoketests?group=eidas-prod'}}],
'channel': '#verify-2ndline' }
json
