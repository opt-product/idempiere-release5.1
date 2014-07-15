-- IDEMPIERE-1998 for backward compatibility insert the creator as scheduler recipient
insert 
into ad_schedulerrecipient 
    (
        ad_schedulerrecipient_id,
        ad_client_id,
        ad_org_id,
        isactive,
        created,
        createdby,
        updated,
        updatedby,
        ad_scheduler_id,
        ad_user_id,
        ad_role_id,
        ad_schedulerrecipient_uu
    )
select nextidfunc(921,'N'), s.ad_client_id, s.ad_org_id, s.isactive, statement_timestamp(), 100, statement_timestamp(), 100, s.ad_scheduler_id, s.createdby, null, generate_uuid()
from ad_scheduler s 
where not exists (  select 1 
                    from ad_schedulerrecipient sr 
                    where s.ad_scheduler_id=sr.ad_scheduler_id)
;

SELECT register_migration_script('201407151334_IDEMPIERE-1998.sql') FROM dual
;

