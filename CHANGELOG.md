# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.7.2] - 2026-07-28

- Bump json, parser, and rubocop dependency versions

## [0.7.1] - 2026-03-03

- `StockLocation` now accepts parameters in initialization and passes them through to the API request
- Update dependencies (faraday, addressable, bigdecimal, json, language_server-protocol) and remove unused mcp/json-schema dependencies

## [0.7.0] - 2026-03-02

- Add QNE stock reports (stock location balance endpoint)
- Downgrade `actions/checkout` to v4 in the CI workflow

## [0.6.0] - 2026-01-20

- Add stock availability endpoint (`Stock#available`)
- Update dependencies

## [0.5.2] - 2025-11-05

- Update dependencies and RuboCop configuration
- Streamline GitHub Actions workflow (consolidate RuboCop/RSpec steps)

## [0.5.1] - 2025-11-05

- Update Gemfile and Gemfile.lock dependency versions

## [0.5.0] - 2025-06-20

- Add `Faraday::Retry` middleware support, including a configurable custom retry block in the `Connection` initializer
- Upgrade to Ruby 3.2.2
- Add example for custom `retry_block` usage to the README

## [0.4.1] - 2025-11-05

- Add GitHub Actions CI workflow for running RSpec and RuboCop
- Pin Ruby version (3.4.7) via `.ruby-version`
- Update RuboCop configuration to enforce single quotes and adjust metrics settings; resolve resulting offenses
- Refactor specs to use `double` instead of `OpenStruct` for response mocks
- Remove `byebug` development dependency
- Update gem dependencies to use minimum version constraints

## [0.4.0] - 2024-10-04

- Add support for configuring request options and timeouts via environment variables

## [0.3.0] - 2024-04-24

- Add `find_by` method

## [0.2.2] - 2024-03-27

- Remove persisted connection

## [0.2.1] - 2024-03-26

- Revise authentication method

## [0.2.0] - 2024-03-26

- Add Sales Invoices resource (list, show, create, update)
- Add Sales Order download
- Add Stock Locations and Stock Finder
- Add `Customer#find`
- Add UOMs (units of measure) endpoint
- Add Tax Codes (input/output) endpoint
- Add Agents endpoint
- Add bearer token authentication support
- Add `faraday-net_http_persistent` support
- Separate `authenticated?` from `connected?`
- Make `#connection` method publicly accessible
- Support datatype-based values for query parameters

## [0.1.0] - 2023-06-08

- Initial release
