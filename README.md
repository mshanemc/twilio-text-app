# Text Messaging App

## Sign Up for Environment, in this case a Free Developer Org:

1. Go to Developer.Salesforce.com
2. Click Sign up on the top right
3. Fill out the form including email and Username. Username should be in the form of an email but doesn’t have to be your actual email. Email should be your actual email you can receive emails to.
4. Configure MyDomain in your new salesforce instance

## Sign up for a Twilio account:

1. Go to [_https://www.twilio.com/_](https://www.twilio.com/)
2. Click Sign Up on the top right
3. Fill out the form

## Install the Twilio for Salesforce App

1. [_https://appexchange.salesforce.com/appxListingDetail?listingId=a0N3A00000EtEuBUAV_](https://appexchange.salesforce.com/appxListingDetail?listingId=a0N3A00000EtEuBUAV)
2. Follow the instructions to install the app in your salesforce (the trial is free)
3. Configure the following the Twilio instructions [_https://www.twilio.com/docs/salesforce/install_](https://www.twilio.com/docs/salesforce/install)

## Decide who you want to send text messages to

1. Twilio can send individual messages, and bulk messages to contacts or leads within a campaign
2. Update any page layouts to contain information you want. Make the pokédex field required or add a validation rule because without a pokédex text messages will not send. (with the trail Twilio app, only confirmed numbers in the Twilio console will receive a text message. You can add your number, and any number you will send a message to. With the full version of the Twilio app it will send any number that hasn’t opted out).

## Make some reports

I created a few reports with charts on each

1. Campaigns with campaign members, grouped by campaign name and last message status
2. Messages with bulk message by status, grouped by status
3. Messages with bulk message, grouped by campaign and then status

## Plan your flow

1. There are some default Twilio send options you can use, but we are going to create a screen flow so we can launch and send messages from any page we want to embed our flow on.
2. My flow is going to give the user an option to send texts to an existing campaign, or to create a new campaign and search for the contacts to add in (you can of course expand this to search leads as well)

![Image: image.png](https://github.com/mshanemc/twilio-text-app/blob/master/assets/text-flow.png?raw=true)

## Create the flow

1. First, I have a screen element allowing the user to choose the type of send, it uses a radio button input with two choice variables to allow the user to select between contact and campaign
2. A decision element routes the flow to either the campaign path or the contact path
3. Contact Path: in the decision element if the contact variable was selected it’s going to have a connector to the contact path
   1. Campaign name screen; we’re providing an input text box for the user to name a new campaign. All of the selected contacts will be added to this new campaign.
   2. Add contacts screen is a screen element presenting a contacts Record choice set (filtered by the 12 most recently modified contacts who have a mobile number) and a text element where the user can enter the full name of a contact to search. This would be easy to expand the search to enter email or ph. number but right now I’m searching on full name.
   3. Next is a decision to find if the user selected a contact or put in a name. if the record choice isn’t selected it’s going onto a screen which will present a record choice set which is filtering contacts by the full name. The user can choose the name the matches and then it will assign this chosen name, or the name chosen from the first record choice set element to a collection
   4. Next is a screen element with a radio choice offering a yes or no choice variable to add more contacts to the campaign or move on.
   5. A decision element moves us back to the Add contact screen or onto a record create.
   6. The first record create will create a campaign with the campaign name that was input by the user. Add any other default field settings here.
   7. The next thing we need to do is loop though all of the contacts that were added to the contact assignment. We loop though them so that we can set their defaults for their campaign member record and add them to the campaign we just created, and then we add those to a campaign member assignment.
   8. Next a fast create will create the campaign members
4. If we had chosen, the use existing campaign path we would then be taken to a screen element that presents a record choice of campaigns
5. The two paths converge at this point and we complete the text message to send
   1. Another screen element will allow the user to enter the text of their text message
   2. A create record will actually use the Twilio bulk send object to create the message, and thus send it out.
   3. The final screen is a screen element that will display a message that the text was successful.
6. Save and activate the flow

## Create an app page

You could imbed this flow on a home page or anywhere really, but we’ll create a new app page to display it and some charts.

1. In setup search for lighting app builder and click New
2. Choose App Page
3. Name the page
4. Choose a layout (I used a 2-region layout)
5. Drag the flow section into the page, and choose the flow we just made
6. On the opposite side of the flow add your reports

Now start sending some messages!!! You could use this for emails with all native functionality if you didn’t want to send text even! Or bulk create tasks or events? Who knows, there are a lot of possibilities
