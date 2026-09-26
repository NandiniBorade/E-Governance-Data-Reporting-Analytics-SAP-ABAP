REPORT zgov_status_report.

TABLES: zgov_citizen_app.

TYPES: BEGIN OF ty_status,
         status TYPE zgov_citizen_app-status,
         count  TYPE i,
       END OF ty_status.

DATA: gt_status TYPE TABLE OF ty_status,
      gs_status TYPE ty_status.

START-OF-SELECTION.

  SELECT status, COUNT( * )
    FROM zgov_citizen_app
    WHERE status IS NOT INITIAL
    GROUP BY status
    INTO TABLE @gt_status.

  IF gt_status IS INITIAL.
    MESSAGE 'No status data found' TYPE 'I'.
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
          t_table      = gt_status ).

      lo_alv->get_functions( )->set_all( abap_true ).

      lo_alv->get_columns( )->set_optimize( abap_true ).

      lo_alv->get_display_settings( )->set_striped_pattern( abap_true ).

      lo_alv->get_display_settings( )->set_list_header(
        'E-Governance Application Status Report' ).

      lo_alv->display( ).

    CATCH cx_salv_msg INTO DATA(lx_msg).

      MESSAGE lx_msg->get_text( ) TYPE 'I'.

  ENDTRY.

ENDFORM.
