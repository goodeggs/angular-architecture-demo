# Angular Demo App

## Principles

- Structure should be consistent across modules
- separate units by function
- controllers do not need unit tests because they are the glue of the application. An integration test is more suitable for testing each app
- Every index file is a top level entry point for that module
- Angular already has a fantastic module management system already, take advantage of Angular's system as much as possible. Use requires for internal files, let angular manage top-level modules
- Group all related files together (including tests for those files)
- Everything that is only intended to be used once goes in apps, everything else intended for reseuse goes in modules
- Avoid long redundant naming (e.g. route_view/route_view.template.coffee -> route_view/template.coffee)
