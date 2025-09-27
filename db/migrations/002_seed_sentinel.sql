-- 002_seed_sentinel.sql
insert into profiles (id, display_name, role)
values ('00000000-0000-0000-0000-000000000000','SYSTEM_CONSENT','admin')
on conflict (id) do nothing;

insert into consent_logs (user_id, consent_version, consent_text)
values (
  '00000000-0000-0000-0000-000000000000',
  'v1',
  'By submitting a review you consent to processing of your health-related opinions for transparency and research purposes. This is not medical advice.'
);
