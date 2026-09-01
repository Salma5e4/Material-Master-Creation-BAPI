
REPORT z_material_bapi_create.

PARAMETERS p_matnr TYPE matnr DEFAULT '000000000000000001'.
PARAMETERS p_desc TYPE maktx DEFAULT 'Laptop Bag'.
PARAMETERS p_mtart TYPE mtart DEFAULT 'ROH'.
PARAMETERS p_meins TYPE meins DEFAULT 'EA'.
PARAMETERS p_werks TYPE werks_d DEFAULT '1000'.
PARAMETERS p_matkl TYPE matkl DEFAULT '001'.

START-OF-SELECTION.

  DATA ls_headdata TYPE bapimathead.
  DATA ls_clientdata TYPE bapi_mara.
  DATA ls_clientdatax TYPE bapi_marax.
  DATA ls_plantdata TYPE bapi_marc.
  DATA ls_plantdatax TYPE bapi_marcx.
  DATA ls_return TYPE bapiret2.
  DATA lt_matdesc TYPE TABLE OF bapi_makt.
  DATA ls_matdesc TYPE bapi_makt.

  WRITE 'Material Master Creation Utility'.
  WRITE '--------------------------------'.
  WRITE: / 'Material Number :', p_matnr.
  WRITE: / 'Description     :', p_desc.
  WRITE: / 'Material Type   :', p_mtart.
  WRITE: / 'Base Unit       :', p_meins.
  WRITE: / 'Plant           :', p_werks.
  WRITE: / 'Material Group  :', p_matkl.
  WRITE '--------------------------------'.

  IF p_desc IS INITIAL.
    WRITE 'ERROR: Material description is required.'.
    RETURN.
  ENDIF.

  IF p_mtart IS INITIAL.
    WRITE 'ERROR: Material type is required.'.
    RETURN.
  ENDIF.

  IF p_meins IS INITIAL.
    WRITE 'ERROR: Base unit is required.'.
    RETURN.
  ENDIF.

  IF p_werks IS INITIAL.
    WRITE 'ERROR: Plant is required.'.
    RETURN.
  ENDIF.

  IF p_matkl IS INITIAL.
    WRITE 'ERROR: Material group is required.'.
    RETURN.
  ENDIF.

  WRITE 'All validations successful.'.
  WRITE 'Calling BAPI_MATERIAL_SAVEDATA...'.

  ls_headdata-material = p_matnr.
  ls_headdata-matl_type = p_mtart.
  ls_headdata-ind_sector = 'M'.
  ls_headdata-basic_view = 'X'.

  ls_clientdata-base_uom = p_meins.
  ls_clientdata-matl_group = p_matkl.

  ls_clientdatax-base_uom = 'X'.
  ls_clientdatax-matl_group = 'X'.

  ls_plantdata-plant = p_werks.
  ls_plantdatax-plant = p_werks.

  ls_matdesc-langu = sy-langu.
  ls_matdesc-matl_desc = p_desc.

  APPEND ls_matdesc TO lt_matdesc.

  CALL FUNCTION 'BAPI_MATERIAL_SAVEDATA'
    EXPORTING
      headdata = ls_headdata
      clientdata = ls_clientdata
      clientdatax = ls_clientdatax
      plantdata = ls_plantdata
      plantdatax = ls_plantdatax
    IMPORTING
      return = ls_return
    TABLES
      materialdescription = lt_matdesc.

  IF ls_return-type = 'E'.
    WRITE '--------------------------------'.
    WRITE 'ERROR: Material creation failed.'.
    WRITE: / ls_return-message.
    CALL FUNCTION 'BAPI_TRANSACTION_ROLLBACK'.
    RETURN.
  ENDIF.

  IF ls_return-type = 'A'.
    WRITE '--------------------------------'.
    WRITE 'ERROR: Material creation aborted.'.
    WRITE: / ls_return-message.
    CALL FUNCTION 'BAPI_TRANSACTION_ROLLBACK'.
    RETURN.
  ENDIF.

  CALL FUNCTION 'BAPI_TRANSACTION_COMMIT'
    EXPORTING
      wait = 'X'.

  WRITE '--------------------------------'.
  WRITE 'Material created or extended successfully!'.
  WRITE: / 'Material Number :', p_matnr.
  WRITE: / 'BAPI Message    :', ls_return-message.
  WRITE '--------------------------------'.

