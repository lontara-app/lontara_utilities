# frozen_string_literal: true

require 'json'
require 'uri'
require 'faraday'

require_relative 'git'
require_relative 'http_client/body_parser'
require_relative 'http_client/request'

module LontaraUtilities
  # Lontara HTTP Client
  #
  # Request dapat menggunakan method `new` disertai HTTP method sebagai parameter,
  # atau menggunakan method predifined `.get`, `.post`, `.put`, `.delete`, `.patch`.
  #
  # Parameter yang dibutuhkan:
  # - method. Contoh: `:get`, `:post`, `:put`, `:delete`. Dapat menerima dalam bentuk String.
  # - :url. Contoh: `http://localhost:4000/book/category`
  # - :params. Contoh: `params: { sort: "createDate,desc" }`
  # - :body. Contoh: `body: { username: admin, password: admin }`
  # - :headers. Headers dapat diisi dengan berbagai key-value dalam format lowercase.
  #             Pisahkan dengan underscore jika key lebih dari satu kata.
  #             Contoh: `headers: { authorization: "Bearer hnjuvdiwv67wwqvn....", content_type: "application/json" }`
  #
  # Contoh:
  #
  #   Lontara::HTTPClient.new(:get,
  #     url: 'http://localhost:4000/book/category',
  #     params: { sort: 'createDate,desc' }
  #   )
  #
  # atau
  #
  #   request = Lontara::HTTPClient.get(
  #     url: 'http://localhost:4000/user',
  #     params: { id: "123GHANIY" },
  #     headers: {
  #       authorization: "Bearer #{token}",
  #       content_type: 'application/json'
  #     }
  #   )
  #
  #   JSON.parse(request.body)
  #
  module HTTPClient
    def self.new(method, url:, **options)
      Request.new(method, url:, **options).perform
    end

    # Use predifined method to make HTTP request.
    %i[get post put delete patch].each do |method|
      define_singleton_method(method) do |url:, **options|
        Request.new(method, url:, **options).perform
      end
    end
  end
end
