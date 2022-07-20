# Instructions

Examine the supplied JSON data in `data.json` and produce an output extract that gives a summary of valid hours, one CSV row per locale.

Each CSV row must have two fields, the first being the locale, double-quoted, and the second being the valid hours value.

The data is within the `locales` property, which is an object where the properties are locales (e.g. "en", "fa", etc) and the values are objects with various details, one of which is the valid hours, in a property called `validHrs`.

Taking the first locale in `data.json`, which is "en", the valid hours value is `2275.28`. The CSV row for this locale must therefore be:

```csv
"en",2275.28
```

## Source

The original source for this exercise is the Stack Overflow item [JSON selector for jq](https://stackoverflow.com/questions/72994933/json-selector-for-jq).

The content of the `data.json` file was sourced from the referenced [Mozilla Common Voice JSON statistics](https://raw.githubusercontent.com/common-voice/cv-dataset/main/datasets/cv-corpus-10.0-2022-07-04.json) resource (with the date 2022-07-04) (for more on Mozilla Common Voice see <https://commonvoice.mozilla.org>). This dataset was retrieved, and then reduced to the first few locale entries, as follows:

```bash
curl \
  --url 'https://raw.githubusercontent.com/common-voice/cv-dataset/main/datasets/cv-corpus-10.0-2022-07-04.json' \
  | jq '.locales|=(to_entries[0:5]|from_entries)' \
  > data.json
```
