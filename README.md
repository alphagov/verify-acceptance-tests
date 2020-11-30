# Hub Acceptance Tests

This is an attempt at a new style of hub acceptance tests using Cucumber and Capybara.
Hopefully, they'll be more maintainable than what we have now.


## Running

Running against staging:
```
./run-tests-with-docker.sh [features-to-run]
```

Running locally:
```
./pre-commit.sh
```
by default, the browser will not open and the tests will run in 3 parallel instances.
In order to run a single instance with visible browser use:
```
./pre-commit.sh --no-parallel
```

To run your tests locally using Chrome instead of Firefox set the `BROWSER` environment variable to `chrome`:
```
BROWSER=chrome ./pre-commit.sh --no-parallel
```

To run them for a different test environment, export the `TEST_ENV` environment variable with one of the following:

  * local
  * docker-local
  * staging

## Configuration

Config for the different test environments is stored in `features/step_definitions/environments.yml`.
