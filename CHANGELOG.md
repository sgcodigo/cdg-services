# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.0.5] - 2018-03-30
### Fixed
- Fit new Google Play store web page HTML structure for android apps

## [0.0.4] - 2017-07-15
### Fixed
- Remove require "pry" in service file

## [0.0.3] - 2017-07-15
### Changed
- Improve method(`CDG::Services.ping_slack!`) to send notification to slack as attachment with more params, but only the necessary ones so that this service does not become a full featured api client that makes use of slack api since there already is 1.

## [0.0.2] - 2017-07-07
### Added
- Add method(`CDG::Services.ping_slack!`) to send notification to slack with some custom params

### Changed
- Rename method `CDG::Services.GetIOSVersion` to `CDG::Services.get_ios_version` to follow ruby naming conventions
- Rename method `CDG::Services.GetAndroidVersion` to `CDG::Services.get_android_version` to follow ruby naming conventions

## [0.0.1] - 2017-07-06
### Added
- Add method (`CDG::Services.GetIOSVersion`) which fetches the latest ios app's version base on app id via a net/http call
- Add method (`CDG::Services.GetAndroidVersion`) which fetches the latest android app's version base on an app id via a net/http call
