#!/usr/bin/env bats
load bats-extra

# local version: 1.1.0.0

@test "Empty input" {
  #[[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run jq -r -f summary_extract.jq <<< ""

  assert_success
  assert_output ""
}

@test "Reduced single locale" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run jq -r -f summary_extract.jq <<EOF
{
  "date": "2022-07-04",
  "locales": {
    "en": {
      "validHrs": 2275.28
    }
  },
  "totalValidHrs": 2275
}
EOF

  assert_success
  cat <<EOF | assert_output -
"en",2275.28
EOF
}

@test "Reduced multiple locales" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run jq -r -f summary_extract.jq <<EOF
{
  "date": "2022-07-04",
  "locales": {
    "en": {
      "validHrs": 2275.28
    },
    "fa": {
      "validHrs": 327.14
    }
  },
  "totalValidHrs": 2602
}
EOF

  assert_success
  cat <<EOF | assert_output -
"en",2275.28
"fa",327.14
EOF
}

@test "Entire dataset" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run jq -r -f summary_extract.jq data.json

  assert_success
  cat <<EOF | assert_output -
"en",2275.28
"fa",327.14
"fr",868.35
"es",411.31
"sl",10.09
EOF
}
