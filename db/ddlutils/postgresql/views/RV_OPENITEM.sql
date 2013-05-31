﻿DROP VIEW rv_openitem;

CREATE OR REPLACE VIEW rv_openitem AS 
SELECT i.ad_org_id,
    i.ad_client_id,
    i.documentno,
    i.c_invoice_id,
    i.c_order_id,
    i.c_bpartner_id,
    i.issotrx,
    i.dateinvoiced,
    i.dateacct,
    p.netdays,
    paymenttermduedate(i.c_paymentterm_id, i.dateinvoiced)            AS duedate,
    paymenttermduedays(i.c_paymentterm_id, i.dateinvoiced, getdate()) AS daysdue,
    adddays(i.dateinvoiced, p.discountdays)                           AS discountdate,
    round(i.grandtotal * p.discount / 100, 2)                         AS discountamt,
    i.grandtotal,
    invoicepaid(i.c_invoice_id, i.c_currency_id, 1)                   AS paidamt,
    invoiceopen(i.c_invoice_id, 0)                                    AS openamt,
    i.c_currency_id,
    i.c_conversiontype_id,
    i.c_paymentterm_id,
    i.ispayschedulevalid,
    NULL                                                              AS c_invoicepayschedule_id,
    i.invoicecollectiontype,
    i.c_campaign_id,
    i.c_project_id,
    i.c_activity_id,
    i.c_invoice_ad_orgtrx_id                                          AS ad_orgtrx_id,
    i.ad_user_id,
    i.c_bpartner_location_id,
    i.c_charge_id,
    i.c_doctype_id,
    i.c_doctypetarget_id,
    i.c_dunninglevel_id,
    i.chargeamt,
    i.c_payment_id,
    i.created,
    i.createdby,
    i.dateordered,
    i.dateprinted,
    i.description,
    i.docaction,
    i.docstatus,
    i.dunninggrace,
    i.generateto,
    i.isactive,
    i.isapproved,
    i.isdiscountprinted,
    i.isindispute,
    i.ispaid,
    i.isprinted,
    i.c_invoice_isselfservice                                         AS isselfservice,
    i.istaxincluded,
    i.istransferred,
    i.m_pricelist_id,
    i.m_rma_id,
    i.paymentrule,
    i.poreference,
    i.posted,
    i.processedon,
    i.processing,
    i.ref_invoice_id,
    i.reversal_id,
    i.salesrep_id,
    i.sendemail,
    i.totallines,
    i.updated,
    i.updatedby,
    i.user1_id,
    i.user2_id 
FROM rv_c_invoice i 
        JOIN c_paymentterm p 
        ON i.c_paymentterm_id = p.c_paymentterm_id 
WHERE invoiceopen(i.c_invoice_id, 0) <> 0 AND i.ispayschedulevalid <> 'Y' AND i.docstatus IN ('CO',
    'CL') 
UNION 
SELECT i.ad_org_id,
    i.ad_client_id,
    i.documentno,
    i.c_invoice_id,
    i.c_order_id,
    i.c_bpartner_id,
    i.issotrx,
    i.dateinvoiced,
    i.dateacct,
    daysbetween(ips.duedate, i.dateinvoiced)                 AS netdays,
    ips.duedate,
    daysbetween(getdate(), ips.duedate)                      AS daysdue,
    ips.discountdate,
    ips.discountamt,
    ips.dueamt                                               AS grandtotal,
    invoicepaid(i.c_invoice_id, i.c_currency_id, 1)          AS paidamt,
    invoiceopen(i.c_invoice_id, ips.c_invoicepayschedule_id) AS openamt,
    i.c_currency_id,
    i.c_conversiontype_id,
    i.c_paymentterm_id,
    i.ispayschedulevalid,
    ips.c_invoicepayschedule_id,
    i.invoicecollectiontype,
    i.c_campaign_id,
    i.c_project_id,
    i.c_activity_id,
    i.c_invoice_ad_orgtrx_id                                 AS ad_orgtrx_id,
    i.ad_user_id,
    i.c_bpartner_location_id,
    i.c_charge_id,
    i.c_doctype_id,
    i.c_doctypetarget_id,
    i.c_dunninglevel_id,
    i.chargeamt,
    i.c_payment_id,
    i.created,
    i.createdby,
    i.dateordered,
    i.dateprinted,
    i.description,
    i.docaction,
    i.docstatus,
    i.dunninggrace,
    i.generateto,
    i.isactive,
    i.isapproved,
    i.isdiscountprinted,
    i.isindispute,
    i.ispaid,
    i.isprinted,
    i.c_invoice_isselfservice                                AS isselfservice,
    i.istaxincluded,
    i.istransferred,
    i.m_pricelist_id,
    i.m_rma_id,
    i.paymentrule,
    i.poreference,
    i.posted,
    i.processedon,
    i.processing,
    i.ref_invoice_id,
    i.reversal_id,
    i.salesrep_id,
    i.sendemail,
    i.totallines,
    i.updated,
    i.updatedby,
    i.user1_id,
    i.user2_id 
FROM rv_c_invoice i 
        JOIN c_invoicepayschedule ips 
        ON i.c_invoice_id = ips.c_invoice_id 
WHERE invoiceopen(i.c_invoice_id, ips.c_invoicepayschedule_id) <> 0 AND i.ispayschedulevalid = 'Y' AND i.docstatus IN ('CO',
    'CL') AND ips.isvalid = 'Y'
;
