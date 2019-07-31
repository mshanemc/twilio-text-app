sfdx force:org:create -f config/project-scratch-def.json -d 1 -s
sfdx force:package:install --package 04t1N000000GrxOQAS -w 60 -r
sfdx force:source:push
sfdx force:user:permset:assign -n MessagingPerms
sfdx force:org:open