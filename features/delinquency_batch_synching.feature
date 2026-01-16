Feature: Delinquency Batch Synching
  As a collections manager
  I want batch synching to update delinquencies correctly
  So that Ai Lean reflects accurate debt status and history

  Background:
    Given I open the Ai Lean login page
    And I log in with username "admin" and password "AILeanSoftware2024!"
    And I am on the Debt List page

  Scenario: New Debt via Batch Synching
    Given a new debt record is received from the FMS batch file
    And the debt does NOT exist as an Active Debt on Ai Lean
    And the PTD is in the past and TDO is greater than 0
    When the Batch Synching process is executed
    Then a new delinquency is created and visible in the Debt List
    And the status is "OK" (Green) with Activity Log "New Debt Added"

  Scenario: Tenant Paid (Evolution to Closed)
    Given an active delinquency exists in Ai Lean
    When the record is missing from the FMS sync 3 consecutive times
    Then the status transitions from "HOLD: Close Paid" (Purple) to "CLOSE: Paid" (Black)
    And the Activity Log reflects the final closure

  Scenario: PTD Moved Earlier (No Impact)
    Given a delinquency that is NOT "Closed" or on "Hold"
    And the FMS PTD is earlier than the current Ai Lean PTD
    When the Batch Synching is executed
    Then the status is set to "Workflow Hold for PTD Change"
    And the Activity Log records "PTD Moved Earlier"

  Scenario: True Partial Payment (PTD Moved Later)
    Given the FMS PTD is later than the current Ai Lean PTD but <= Current Date
    And TDO is still greater than 0
    When the Batch Synching is executed
    Then the status is set to "Workflow Hold for PTD Change"
    And the Activity Log records "PTD Moved Later, ReStart for Partial Payment"

  Scenario: Inconsistent Info (Future PTD)
    Given the FMS PTD is in the future (> Current Date)
    And TDO is still greater than 0
    When the Batch Synching is executed
    Then the status is set to "Workflow Hold for PTD Change"
    And the Activity Log records "Inconsistent Delinquency information, possible error"

  Scenario: Chargeback Processing
    Given a delinquency with stage "Closed"
    And the incoming FMS PTD moves backwards (earlier than Ai Lean PTD)
    When the Batch Synching is executed
    Then the debt is set to "ReStart" and requires Approval
    And the Activity Log records "Restart Due to chargeback"

  Scenario: Fast Redelinquency (Month-End)
    Given a debt in status "HOLD Close Paid"
    And the FMS PTD is later than the Ai Lean PTD (new month owed)
    When the Batch Synching is executed
    Then the system closes the first debt and automatically creates a second delinquency record
