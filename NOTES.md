# Video Viewer App

###### Tools:

1. Rails
2. Active Record Gem
3. Active Model Serializer Gem
4. Webpacker Gem
5. Shoulda Gem
6. Database Cleaner Gem
7. Spec Gem
8. Capybara Gem
9. Selenium Gem
10. Selenium Server Gem
11. React
12. Redux
13. Redux Thunk

###### Models:
1. Video
    1. Title : String : Required
    2. Description : Text : Required
    3. YoutubeVideoID : String : Required
    4. Has Many Comments
2. Comments
    1. Content : Text: Required
    2. Rating : Integer : Required : 0 - 5 Range
    3. Belongs To A Video

###### API Routes:
1. Video Routes
    1. GET /api/videos
        1. Returns Collection Of Videos
    2. POST /api/videos
        1. Creates A Video And Returns New Video
    3. GET /api/video/:id
        1. Returns A Video And Returns New Video
    4. PUT /api/videos/:id
        1. Updates and Returns The Video Matching The Parameters ID
    5. DELETE /api/videos/:id
        1. Destroys The Video Matching The Parameters ID

2. Comment Routes
    1. GET /api/videos/:video_id/comments
        1. Returns Collection Of A Video’s Comments
    2. POST /api/videos/:video_id/comments
        1. Creates And Returns A Created Comment For A Video
    3. GET /api/videos/:video_id/comments/:id
        1. Returns A Comment For A Comment Matching The Parameter IDs
    4. PUT /api/videos/:video_id/comments/:id
        1. Updates and Returns The Comment For A Comment Matching The Parameter IDs
    5. DELETE /api/videos/:video_id/comments/:id
1. Destroy The Comment For Comment Matching The Parameter IDs

###### Webpacker
