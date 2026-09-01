# Material Master Creation Utility using BAPI

## Project Overview

This project is an ABAP-based Material Master Creation Utility developed in SAP S/4HANA.

The application validates material master information and uses the standard SAP BAPI_MATERIAL_SAVEDATA function module to create or extend material data.

## Objective

The objective of this project is to simplify the material creation process by:

- Accepting material master information from the user
- Validating mandatory fields
- Calling the standard SAP BAPI
- Handling BAPI success and error messages
- Committing the transaction
- Verifying the material in SAP

## Technologies Used

- SAP S/4HANA
- ABAP
- SAP GUI
- Function Modules
- BAPI

## BAPI Used

BAPI_MATERIAL_SAVEDATA

## SAP Transactions Used

- SE38 - ABAP Editor
- SE37 - Function Builder
- MM03 - Display Material

## Input Fields

| Field | Example |
|---|---|
| Material Number | 000000000000000001 |
| Description | Laptop Bag |
| Material Type | ROH |
| Base Unit | EA |
| Plant | 1000 |
| Material Group | 001 |

## Project Flow

User Input  
↓  
Input Validation  
↓  
BAPI_MATERIAL_SAVEDATA  
↓  
Check Return Message  
↓  
BAPI_TRANSACTION_COMMIT  
↓  
Material Created/Extended  
↓  
Material Verification using MM03

## Features

- Material master data input
- Mandatory field validation
- Material type validation
- Base unit validation
- Plant validation
- Material group validation
- Material creation/extension using BAPI
- Success and error message handling
- Transaction commit and rollback
- Material verification using MM03

## Validation

The program validates the required material fields before calling the BAPI.

If validation fails, an appropriate error message is displayed and the creation process is stopped.

## Test Data

- Material Number: 1
- Material Description: Laptop Bag
- Material Type: ROH
- Base Unit: EA
- Plant: 1000
- Material Group: 001

## Result

The material was successfully created or extended using BAPI_MATERIAL_SAVEDATA.

SAP returned:

> The material 1 has been created or extended.

The material was also verified successfully using MM03.

## Project Structure

```text
Material-Master-Creation-BAPI/
│
├── z_material_bapi_create.abap
├── 01_selection_screen.png
├── 02_program_output.png
├── 03_bapi_test.png
├── 04_material_mm03.png
└── README.md
