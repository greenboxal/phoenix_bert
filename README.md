# Phoenix BERT

[![Build Status](https://travis-ci.org/veyond-card/phoenix_bert.svg?branch=master)](https://travis-ci.org/veyond-card/phoenix_bert)
[![Inline docs](http://inch-ci.org/github/veyond-card/phoenix_bert.svg?branch=master)](http://inch-ci.org/github/veyond-card/phoenix_bert)

This library makes [BERT](https://birt-rpc.org) available to Phoenix so you can encode/decode it.

## Usage

Add the following configuration to phoenix:

    config :phoenix, :format_encoders,
      bert: PhoenixBert

And add "bert" as an acceptable format to :accepts plug

    plug :accepts, ["json", "bert"]

## License

Plug source code is released under MIT License.
Check LICENSE file for more information.

