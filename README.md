# CartafactRb

A Ruby-based client for using the Cartafact Document Store.

## Usage

The primary interface to the client is achieved using the `CartafactRb::Client` class.

## Documentation

Documentation can be generated with `bundle exec yard`.

## Tests

Tests can be run with `bundle exec rspec`.

You can additionally generate code coverage data by setting the `COVERAGE` environment variable before running specs:
`COVERAGE=1 bundle exec rspec`

Coverage data will be available in HTML format in the `coverage` directory.

## Style and Linting

Style and linting is performed using Rubocop.

## Development Status

Document Capabilities:
* [x] List
* [x] Read
* [x] Download
* [ ] Create

Advanced Client Capabilities:
* [ ] Abstracted Retry
* [ ] Abstracted Error Handling and Exceptions
* [ ] Streaming Document Download

Quality Tools:
* [x] RSpec (coverage lacking in important areas)
* [x] SimpleCov
* [x] Rubocop
* [x] Yard (documentation is incomplete)
* [ ] Github Actions
  * [x] RSpec
  * [ ] Rubocop
  * [ ] Coverage