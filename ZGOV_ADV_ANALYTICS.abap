REPORT zgov_adv_analytics.

TABLES: zgov_citizen_app.

SELECT-OPTIONS:
  s_date FOR zgov_citizen_app-application_date.

DATA: lt_data TYPE TABLE OF zgov_citizen_app,
      ls_data TYPE zgov_citizen_app.

DATA: gv_total_applications     TYPE i,
      gv_approved_applications  TYPE i,
      gv_pending_applications   TYPE i,
      gv_rejected_applications  TYPE i,
      gv_total_documents        TYPE i,
      gv_verified_documents     TYPE i,
      gv_total_certificates     TYPE i,
      gv_generated_certificates TYPE i.

DATA: gv_approval_percent   TYPE p DECIMALS 2,
      gv_pending_percent    TYPE p DECIMALS 2,
      gv_rejection_percent  TYPE p DECIMALS 2,
      gv_certificate_percent TYPE p DECIMALS 2.

START-OF-SELECTION.

  SELECT *
    FROM zgov_citizen_app
    INTO TABLE @lt_data
    WHERE application_date IN @s_date.

  IF lt_data IS INITIAL.
    MESSAGE 'No data found for the selected date range' TYPE 'I'.
    EXIT.
  ENDIF.

  LOOP AT lt_data INTO ls_data.

    IF ls_data-aaplication_id IS NOT INITIAL.
      gv_total_applications = gv_total_applications + 1.
    ENDIF.

    IF ls_data-status = 'APPROVED'.
      gv_approved_applications = gv_approved_applications + 1.
    ENDIF.

    IF ls_data-status = 'PENDING'.
      gv_pending_applications = gv_pending_applications + 1.
    ENDIF.

    IF ls_data-status = 'REJECTED'.
      gv_rejected_applications = gv_rejected_applications + 1.
    ENDIF.

    IF ls_data-document_id IS NOT INITIAL.
      gv_total_documents = gv_total_documents + 1.
    ENDIF.

    IF ls_data-verification_status = 'VERIFIED'.
      gv_verified_documents = gv_verified_documents + 1.
    ENDIF.

    IF ls_data-certificate_id IS NOT INITIAL.
      gv_total_certificates = gv_total_certificates + 1.
    ENDIF.

    IF ls_data-cert_status = 'GENERATED'.
      gv_generated_certificates = gv_generated_certificates + 1.
    ENDIF.

  ENDLOOP.

  IF gv_total_applications > 0.

    gv_approval_percent =
      ( gv_approved_applications * 100 ) / gv_total_applications.

    gv_pending_percent =
      ( gv_pending_applications * 100 ) / gv_total_applications.

    gv_rejection_percent =
      ( gv_rejected_applications * 100 ) / gv_total_applications.

  ENDIF.

  IF gv_total_certificates > 0.

    gv_certificate_percent =
      ( gv_generated_certificates * 100 ) / gv_total_certificates.

  ENDIF.

  PERFORM display_analytics.


FORM display_analytics.

  WRITE: / '==============================================',
         / '       E-GOVERNANCE ADVANCED ANALYTICS',
         / '==============================================',
         /.

  WRITE: / 'APPLICATION ANALYTICS'.

  WRITE: / 'Total Applications     :', gv_total_applications.
  WRITE: / 'Approved Applications  :', gv_approved_applications.
  WRITE: / 'Pending Applications   :', gv_pending_applications.
  WRITE: / 'Rejected Applications  :', gv_rejected_applications.

  SKIP 1.

  WRITE: / 'APPROVAL PERCENTAGE    :', gv_approval_percent, '%'.
  WRITE: / 'PENDING PERCENTAGE     :', gv_pending_percent, '%'.
  WRITE: / 'REJECTION PERCENTAGE   :', gv_rejection_percent, '%'.

  SKIP 1.

  WRITE: / 'DOCUMENT ANALYTICS'.

  WRITE: / 'Total Documents        :', gv_total_documents.
  WRITE: / 'Verified Documents     :', gv_verified_documents.

  SKIP 1.

  WRITE: / 'CERTIFICATE ANALYTICS'.

  WRITE: / 'Total Certificates     :', gv_total_certificates.
  WRITE: / 'Generated Certificates :', gv_generated_certificates.
  WRITE: / 'Generation Percentage  :', gv_certificate_percent, '%'.

ENDFORM.
