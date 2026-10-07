#!/bin/bash
systemctl list-unit-files --state=enabled --type=service --no-pager --no-legend | awk '{print $1}'
