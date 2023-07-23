require "spec"
require "webmock"
require "../src/saber"
Spec.before_each &->WebMock.reset
Spec.before_each { Saber.api_key = "test" }
