#!/usr/bin/env ruby

require "minitest/autorun"
require "minitest/reporters"
require "shoulda/context"

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

require "json_encoder"

module JsonEncoder

  class TestEncoder < Minitest::Test

    context "encoder" do

      should "encode strings" do
        assert_equal "$HELLO $WORLD", JsonEncoder.encode("Hello World")
      end

      should "encode integers" do
        assert_equal "123", JsonEncoder.encode(123)
      end

      should "encode floats" do
        assert_equal "11$.22", JsonEncoder.encode(11.22)
      end

      should "encode true" do
        assert_equal "TRUE", JsonEncoder.encode(true)
      end

      should "encode false" do
        assert_equal "FALSE", JsonEncoder.encode(false)
      end

      should "encode nil" do
        assert_equal "NULL", JsonEncoder.encode(nil)
      end

      should "encode objects" do
        assert_equal "KEY.VALUE", JsonEncoder.encode({key: "value"})
      end

      should "encode arrays" do
        assert_equal "-1.2.3", JsonEncoder.encode([1, 2, 3])
      end

      should "encode complex objects" do
        assert_equal "F.1$.1.I.1.S.A.A.-1.2+.O.*K.V", JsonEncoder.encode({s: "a", i: 1, f: 1.1, a: [1,2], o: {k: "v"}})
      end

      should "encode escaped strings" do
        assert_equal "EMAIL$9ADDRESS$8DOMAIN$.COM", JsonEncoder.encode("email_address@domain.com")
      end

      should "encode money" do
        assert_equal "$$1$.23", JsonEncoder.encode("$1.23")
      end

      should "encode dates" do
        assert_equal "8$313$321", JsonEncoder.encode("8/13/21")
      end

      should "encode times" do
        assert_equal "12$406$423", JsonEncoder.encode("12:06:23")
      end

      should "encode IP addresses" do
        assert_equal "127$.0$.0$.1", JsonEncoder.encode("127.0.0.1")
      end

      should "encode base64" do
        assert_equal "$S$G$VSB$G8G$V29YB$G$Q$6", JsonEncoder.encode("SGVsbG8gV29ybGQ=")
      end

      should "encode urls" do
        assert_equal "HTTPS$4$3$3WWW$.EXAMPLE$.COM$7QUERY$6$HELLO%2520$WORLD", JsonEncoder.encode("https://www.example.com?query=Hello%20World")
      end

      should "encode negative integers" do
        assert_equal "$-123", JsonEncoder.encode(-123)
      end

      should "encode negative floats" do
        assert_equal "$-11$.22", JsonEncoder.encode(-11.22)
      end

      should "encode example" do
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

        assert_equal "DATE.8$313$321.EMAIL.JRRUETHE$8GMAIL$.COM.LICENSE.$G$P$LV3.PURPOSE.$JSON ENCODER FOR $Q$R CODES.NAME.*FIRST.$JOE.LAST.$RUETHER+.TEST.-1.2$.2.*THREE.-4.5$.5.SIX", JsonEncoder.encode(truth)
      end

    end

  end

end