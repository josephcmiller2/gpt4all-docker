#!/bin/bash


echo "Starting container..."
sleep 5
systemctl start default.target
echo "done."

exec bash
