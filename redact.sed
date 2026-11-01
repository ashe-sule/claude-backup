s#(postgres(ql)?|mysql|mongodb(\+srv)?|redis|amqp)://([^:/@" \]+):[^@" \]+@#\1://\4:[REDACTED]@#g
s#sk-(ant-)?[A-Za-z0-9_-]{20,}#[REDACTED_KEY]#g
s#(ghp|gho|ghu|ghs|ghr)_[A-Za-z0-9]{30,}#[REDACTED_GH]#g
s#github_pat_[A-Za-z0-9_]{20,}#[REDACTED_GH]#g
s#AKIA[0-9A-Z]{16}#[REDACTED_AWS]#g
s#xox[abprs]-[A-Za-z0-9-]{10,}#[REDACTED_SLACK]#g
s#pat-[a-z0-9]{2,4}-[0-9a-f-]{30,}#[REDACTED_HUBSPOT]#g
s#eyJ[A-Za-z0-9_-]{10,}\.eyJ[A-Za-z0-9_-]{10,}\.[A-Za-z0-9_-]{10,}#[REDACTED_JWT]#g
s#-----BEGIN [A-Z ]*PRIVATE KEY-----.*-----END [A-Z ]*PRIVATE KEY-----#[REDACTED_PRIVATE_KEY]#g
s#([A-Z0-9_]*(PASSWORD|PASSWD|SECRET|TOKEN|API_KEY|APIKEY|ACCESS_KEY)[A-Z0-9_]*)=([^ "\$<{][^ "\]{3,})#\1=[REDACTED]#g
s#("[A-Za-z_]*([Pp]assword|[Ss]ecret|[Tt]oken|[Aa]pi[_-]?[Kk]ey)[A-Za-z_]*\?"\s*:\s*\?")[^"\]{6,}#\1[REDACTED]#g
