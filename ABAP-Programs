REPORT zgov_analytics_report.

TABLES: zgov_citizen_app.

DATA: lt_data TYPE TABLE OF zgov_citizen_app,
      ls_data TYPE zgov_citizen_app.

DATA: gv_total_applications    TYPE i,
      gv_approved_applications TYPE i,
      gv_pending_applications  TYPE i,
      gv_rejected_applications TYPE i,
      gv_total_documents       TYPE i,
      gv_verified_documents    TYPE i,
      gv_pending_documents     TYPE i,
      gv_total_certificates    TYPE i,
      gv_generated_certificates TYPE i,
      gv_pending_certificates  TYPE i.

START-OF-SELECTION.

  SELECT *
    FROM zgov_citizen_app
    INTO TABLE @lt_data.

  IF lt_data IS INITIAL.
    MESSAGE 'No data found for analytics' TYPE 'I'.
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

    IF ls_data-verification_status = 'PENDING'.
      gv_pending_documents = gv_pending_documents + 1.
    ENDIF.

    IF ls_data-certificate_id IS NOT INITIAL.
      gv_total_certificates = gv_total_certificates + 1.
    ENDIF.

    IF ls_data-cert_status = 'GENERATED'.
      gv_generated_certificates = gv_generated_certificates + 1.
    ENDIF.

    IF ls_data-cert_status = 'PENDING'.
      gv_pending_certificates = gv_pending_certificates + 1.
    ENDIF.

  ENDLOOP.

  PERFORM display_analytics.


FORM display_analytics.

  WRITE: / '==============================================',
         / '       E-GOVERNANCE KPI ANALYTICS',
         / '==============================================',
         /.

  WRITE: / 'APPLICATION ANALYTICS'.
  WRITE: / 'Total Applications     :', gv_total_applications.
  WRITE: / 'Approved Applications  :', gv_approved_applications.
  WRITE: / 'Pending Applications   :', gv_pending_applications.
  WRITE: / 'Rejected Applications  :', gv_rejected_applications.

  SKIP 1.

  WRITE: / 'DOCUMENT ANALYTICS'.
  WRITE: / 'Total Documents        :', gv_total_documents.
  WRITE: / 'Verified Documents     :', gv_verified_documents.
  WRITE: / 'Pending Documents      :', gv_pending_documents.

  SKIP 1.

  WRITE: / 'CERTIFICATE ANALYTICS'.
  WRITE: / 'Total Certificates     :', gv_total_certificates.
  WRITE: / 'Generated Certificates:', gv_generated_certificates.
  WRITE: / 'Pending Certificates   :', gv_pending_certificates.

ENDFORM.
