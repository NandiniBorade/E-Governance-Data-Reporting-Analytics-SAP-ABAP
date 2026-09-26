REPORT zgov_document_report.

TABLES: zgov_citizen_app.

DATA: gt_data TYPE TABLE OF zgov_citizen_app,
      gs_data TYPE zgov_citizen_app.

SELECT-OPTIONS:
  s_citid FOR zgov_citizen_app-citizen_id,
  s_appid FOR zgov_citizen_app-aaplication_id,
  s_docid FOR zgov_citizen_app-document_id.

PARAMETERS:
  p_vstat TYPE zgov_citizen_app-verification_status.

START-OF-SELECTION.

  SELECT *
    FROM zgov_citizen_app
    INTO TABLE @gt_data
    WHERE citizen_id     IN @s_citid
      AND aaplication_id IN @s_appid
      AND document_id    IN @s_docid.

  IF p_vstat IS NOT INITIAL.
    DELETE gt_data WHERE verification_status <> p_vstat.
  ENDIF.

  IF gt_data IS INITIAL.
    MESSAGE 'No document data found for the given selection' TYPE 'I'.
    EXIT.
  ENDIF.

  PERFORM display_report.


FORM display_report.

  DATA: lo_alv TYPE REF TO cl_salv_table.

  TRY.

      cl_salv_table=>factory(
        IMPORTING
          r_salv_table = lo_alv
        CHANGING
          t_table      = gt_data ).

      lo_alv->get_functions( )->set_all( abap_true ).

      lo_alv->get_columns( )->set_optimize( abap_true ).

      lo_alv->get_display_settings( )->set_striped_pattern( abap_true ).

      lo_alv->get_display_settings( )->set_list_header(
        'E-Governance Document Verification Report' ).

      lo_alv->display( ).

    CATCH cx_salv_msg INTO DATA(lx_msg).

      MESSAGE lx_msg->get_text( ) TYPE 'I'.

  ENDTRY.

ENDFORM.
