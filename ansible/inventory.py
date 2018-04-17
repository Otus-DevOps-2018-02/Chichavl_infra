#!/usr/bin/env python

import argparse
import json

class Inventory(object):
    def __init__(self):
        self.json_inventory = {
            "app": {
                "hosts": ["appserver"],
                "vars": {
                    "ansible_host": "35.195.11.128"
                }
            },
            "db": {
                "hosts": ["dbserver"],
                "vars": {
                    "ansible_host": "35.190.218.246"
                }
            }
        }

    def list(self):
        return json.dumps(self.json_inventory)


if __name__ == '__main__':
    inventory = Inventory()

    parser = argparse.ArgumentParser(description='Dynamic inventory mock')
    parser.add_argument('--list', action='store_true')
    args = parser.parse_args()

    if args.list:
        print(inventory.list())
