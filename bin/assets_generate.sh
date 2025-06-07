#!/usr/bin/env bash

fvm flutter test test/steam_assets/generate_steam_assets_test.dart --update-goldens --tags=app_store_screenshots

rm -r docs/steam_assets/
mv assets_dev/steam docs/steam_assets
