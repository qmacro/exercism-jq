#!/usr/bin/env jq

.locales|to_entries[]|[.key, .value.validHrs]|@csv
