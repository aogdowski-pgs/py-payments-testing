Feature: Payment form translations

  As a user
  I want to use card payments method
  In order to check full payment functionality in various languages

  Background:
    Given JavaScript configuration is set for scenario based on scenario's @config tag
    And User opens page with payment form

  @base_config @translations
  Scenario Outline: Checking translations of labels and fields error for <language>
    When User changes page language to "<language>"
    And User clicks Pay button
    Then User will see all labels displayed on page translated into "<language>"
    And User will see validation message "Field is required" under all fields translated into "<language>"

    @smoke_test @extended_tests_part_1
    Examples:
      | language |
      | de_DE    |

    Examples:
      | language |
      | en_GB    |
      | fr_FR    |
      | en_US    |
      | cy_GB    |
      | da_DK    |
      | es_ES    |
      | nl_NL    |
      | no_NO    |
      | sv_SE    |

  @config_animated_card_true @animated_card @extended_tests_part_1 @translations
  Scenario Outline: Checking animated card translation for <language>
    When User changes page language to "<language>"
    And User fills payment form with credit card number "340000000000611", expiration date "12/22" and cvv "123"
    Then User will see that labels displayed on animated card are translated into "<language>"

    Examples:
      | language |
      | de_DE    |

  @base_config @translations
  Scenario Outline: Checking translation of fields validation for <language>
    When User changes page language to "<language>"
    And User fills payment form with credit card number "4000000000000051 ", expiration date "12/22" and cvv "12"
    And User clicks Pay button
    Then User will see validation message "Value mismatch pattern" under "SECURITY_CODE" field translated into <language>

    Examples:
      | language |
      | fr_FR    |
      #| de_DE    |

  @base_config @translations
  Scenario Outline: Checking translation of backend fields validation for <language>
    When User changes page language to "<language>"
    And User fills payment form with credit card number "4000000000001059", expiration date "01/22" and cvv "123"
    And InvalidField response set for "CARD_NUMBER"
    And User clicks Pay button
    Then User will see "Invalid field" payment status translated into "<language>"
    Then User will see validation message "Invalid field" under "CARD_NUMBER" field translated into <language>

    Examples:
      | language |
      | es_ES    |
      #| de_DE    |

  @base_config @extended_tests_part_1 @translations
  Scenario Outline: Cardinal Commerce - checking "Success" status translation for <language>
    When User changes page language to "<language>"
    And User fills payment form with credit card number "4000000000001059", expiration date "01/22" and cvv "123"
    And THREEDQUERY mock response is set to "NOT_ENROLLED_N"
    And User clicks Pay button - AUTH response is set to "OK"
    Then User will see "Payment has been successfully processed" payment status translated into "<language>"
    And AUTH and THREEDQUERY requests were sent only once with correct data

    Examples:
      | language |
      | no_NO    |

    #Examples:
      #| language |
      #| de_DE    |