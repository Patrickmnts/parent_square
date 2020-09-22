# README

* There shouldn't be too much out of the ordinary with the set up here.

Built using Ruby 2.3.1 (reflected in .ruby-version)
Steps to bootstrap should only require bundle install.

Built with Rails 5 because my the local dev environment on my personal computer is WAY out of date and it was not worth the fight to untangle everything.

To exercise application via the Rails console
```
 message = Message.create(to_number: '123456789', content: "Your message content")
 SmsService.call(message)
```

To send a message via Curl
```
curl -X POST -H "Content-Type: application/json" -d '{ "to_number": "123456789", "content": "Such a good message" }' "http://localhost:3000/messages"
```

Core functionality can be found in app/services/sms_service.rb

Thank you for taking the time to look things over and I look forward to our next conversation.

Patrick.