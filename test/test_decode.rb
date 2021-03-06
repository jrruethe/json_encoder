#!/usr/bin/env ruby

require "minitest/autorun"
require "minitest/reporters"
require "shoulda/context"

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

require "json_encoder"

module JsonEncoder

  class TestDecoder < Minitest::Test

    context "decoder" do

      should "decode strings" do
        assert_equal "Hello World", JsonEncoder.decode("$HELLO $WORLD")
      end

      should "decode integers" do
        assert_equal 123, JsonEncoder.decode("123")
      end

      should "decode floats" do
        assert_equal 11.22, JsonEncoder.decode("11$.22")
      end

      should "decode true" do
        assert_equal true, JsonEncoder.decode("TRUE")
      end

      should "decode false" do
        assert_equal false, JsonEncoder.decode("FALSE")
      end

      should "decode nil" do
        assert_nil JsonEncoder.decode("NULL")
      end

      should "decode objects" do
        assert_equal ({key: "value"}), JsonEncoder.decode("*KEY.VALUE+")
      end

      should "decode unpadded objects" do
        assert_equal ({key: "value"}), JsonEncoder.decode("*KEY.VALUE")
      end

      should "decode unprefixed objects" do
        assert_equal ({key: "value"}), JsonEncoder.decode("KEY.VALUE")
      end

      should "decode arrays" do
        assert_equal [1, 2, 3], JsonEncoder.decode("-1.2.3")
      end

      should "decode complex objects" do
        assert_equal ({s: "a", i: 1, f: 1.1, a: [1,2], o: {k: "v"}}), JsonEncoder.decode("S.A.I.1.F.1$.1.A.-1.2+.O.*K.V")
      end

      should "decode escaped strings" do
        assert_equal "email_address@domain.com", JsonEncoder.decode("EMAIL$9ADDRESS$8DOMAIN$.COM")
      end

      should "decode money" do
        assert_equal "$1.23", JsonEncoder.decode("$$1$.23")
      end

      should "decode dates" do
        assert_equal "8/13/21", JsonEncoder.decode("8$313$321")
      end

      should "decode times" do
        assert_equal "12:06:23", JsonEncoder.decode("12$406$423")
      end

      should "decode IP addresses" do
        assert_equal "127.0.0.1", JsonEncoder.decode("127$.0$.0$.1")
      end

      should "decode base64" do
        assert_equal "SGVsbG8gV29ybGQ=", JsonEncoder.decode("$S$G$VSB$G8G$V29YB$G$Q$6")
      end

      should "decode urls" do
        assert_equal "https://www.example.com?query=Hello%20World", JsonEncoder.decode("HTTPS$4$3$3WWW$.EXAMPLE$.COM$7QUERY$6$HELLO%2520$WORLD")
      end

      should "decode 0-prefixed integers as strings" do
        assert_equal "0123", JsonEncoder.decode("0123")
      end

      should "decode negative integers" do
        assert_equal (-123), JsonEncoder.decode("$-123")
      end

      should "decode negative floats" do
        assert_equal (-11.22), JsonEncoder.decode("$-11$.22")
      end

      should "decode example" do
        truth =
        {
          name:
          {
            first: "Joe",
            last: "Ruether"
          },
          email: "jrruethe@gmail.com",
          date: "8/13/21",
          license: "GPLv3",
          test: [1, 2.2, {three: [4, 5.5, "six"]}],
          purpose: "Json encoder for QR codes"
        }

        assert_equal truth, JsonEncoder.decode("NAME.*FIRST.$JOE.LAST.$RUETHER+.EMAIL.JRRUETHE$8GMAIL$.COM.DATE.8$313$321.LICENSE.$G$P$LV3.TEST.-1.2$.2.*THREE.-4.5$.5.SIX+++.PURPOSE.$JSON ENCODER FOR $Q$R CODES")
      end

    end

  end

end