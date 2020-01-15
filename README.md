This is a repro script for firebase issue 00031962.

## Running
You'll need bash, curl, grep, node, npm, and a firebase project.
The script assumes you use the default `<project-id>.firebaseapp.com` site.

Run `FIREBASE_PROJECT_ID=<project-id> ./run.sh`.

## Expected output
* The last line should be `< content-type: application/octet-stream`.
* Navigating to `https://<project-id>.firebaseapp.com/hello` in chrome or firefox should download the raw file.

## Actual output
* The last line is `< content-type: application/x-gzip`.
* Navigating to `https://<project-id>.firebaseapp.com/hello` in chrome will download a `hello.gz` file instead, it will be the raw file, not gzipped, but it will be renamed.
* Navigating to `https://<project-id>.firebaseapp.com/hello` in firefox will download a `hello` file, a gzip archive containing the original `hello` file.

## Workaround
You can get the `Content-Type` header to be the right value by hard-coding the header value in the firebase config file with:
```json
{
  "hosting": {
    // ...

    "headers": [
      {
        "source": "/myFile",
        "headers": [
          { "key": "Content-Type", "value": "application/octet-stream" }
        ]
      }
    ]
  }
}
```
