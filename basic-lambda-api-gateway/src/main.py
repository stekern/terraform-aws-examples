#!/usr/bin/env python
#
# Copyright (C) 2020 Erlend Ekern
#
# Distributed under terms of the MIT license.

"""
A Lambda function that returns a JSON-encoded payload.
"""
import json
import logging

logger = logging.getLogger(__name__)
logger.setLevel(logging.INFO)

def lambda_handler(event, context):
    logger.info("Lambda triggered with input data '%s'", json.dumps(event))
    params = event.get("queryStringParameters", {}) or {}
    name = params.get("name", "World")
    payload = json.dumps({
        "greeting": f"Hello, {name}!"
    })
    logger.info("Responding with payload '%s'", payload)
    return {
        "statusCode": 200,
        "body": payload
    }
