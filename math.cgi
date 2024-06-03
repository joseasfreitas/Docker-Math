#!/bin/bash

# Parse the query string
QUERY_STRING=$(echo "$QUERY_STRING" | tr -d '\n')
OPERATION=$(echo "$QUERY_STRING" | cut -d '=' -f 1)
EXPRESSION=$(echo "$QUERY_STRING" | cut -d '=' -f 2 | tr -d ' ')

# Perform the math operation
if [ "$OPERATION" = "ADD" ]; then
    RESULT=$(($EXPRESSION))
elif [ "$OPERATION" = "SUBTRACT" ]; then
    RESULT=$(($EXPRESSION))
elif [ "$OPERATION" = "MULTIPLY" ]; then
    RESULT=$(($EXPRESSION))
elif [ "$OPERATION" = "DIVIDE" ]; then
    RESULT=$(($EXPRESSION))
fi

# Debug output
echo "Query string: $QUERY_STRING" >> /usr/local/apache2/cgi-bin/debug.log
echo "Expression: $EXPRESSION" >> /usr/local/apache2/cgi-bin/debug.log
echo "Result (before formatting): $RESULT" >> /usr/local/apache2/cgi-bin/debug.log

# Format the result for display
if [ -n "$RESULT" ]; then
    RESULT_HTML="<h1>Result: $RESULT</h1>"
else
    RESULT_HTML="<h1>No result available</h1>"
fi

# Print the HTML response
echo "Content-Type: text/html"
echo ""
echo "<html>"
echo "<head><title>Math Result</title></head>"
echo "<body>"
echo "$RESULT_HTML"
echo "</body>"
echo "</html>"
