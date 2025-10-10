def lambda_handler(event, context):
    method = event.get('httpMethod', 'Unknown')
    path = event.get('path', 'Unknown')
    
    html_content = f"""<!DOCTYPE html>
<html>
<head>
    <title>My Lambda Webpage</title>
    <style>
        body {{ font-family: Arial; margin: 40px; background: #f0f0f0; }}
        .container {{ background: white; padding: 30px; border-radius: 8px; }}
        h1 {{ color: #333; }}
        .info {{ background: #e7f3ff; padding: 15px; border-radius: 4px; }}
    </style>
</head>
<body>
    <div class="container">
        <h1>Hello from Avinash!</h1>
        <p>This webpage is served by AWS Lambda function via API Gateway.</p>
        <div class="info">
            <h3>Request Details:</h3>
            <p><strong>Method:</strong> {method}</p>
            <p><strong>Path:</strong> {path}</p>
            <p><strong>Region:</strong> ap-south-1</p>
        </div>
    </div>
</body>
</html>"""
    
    return {
        'statusCode': 200,
        'headers': {
            'Content-Type': 'text/html'
        },
        'body': html_content
    }
