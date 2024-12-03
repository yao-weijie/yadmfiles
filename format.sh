#!/bin/bash

stylua -f ./config/nvim/.stylua.toml .
ruff format
