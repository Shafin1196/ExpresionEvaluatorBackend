import subprocess
import os
from rest_framework.decorators import api_view
from rest_framework.response import Response
from rest_framework import status

@api_view(["POST"])
def parse_expression(request):
    expr = request.data.get("expression")
    if not expr:
        return Response({"error": "No expression provided"}, status=status.HTTP_400_BAD_REQUEST)

    parser_path = os.path.join(os.path.dirname(__file__), "parsers", "myparser")

    try:
        result = subprocess.run(
            [parser_path],
            input=expr + "\n",
            capture_output=True,
            text=True
        )

        if result.returncode != 0:
            return Response({"error": result.stderr.strip()}, status=status.HTTP_400_BAD_REQUEST)

        return Response({"result": result.stdout.strip()})
    except FileNotFoundError:
        return Response({"error": "Parser executable not found"}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)

@api_view(["POST"])
def three_operand(request):
    expr = request.data.get("expression")
    if not expr:
        return Response({"error": "No expression provided"}, status=status.HTTP_400_BAD_REQUEST)

    parser_path = os.path.join(os.path.dirname(__file__), "parsers", "myparser1")

    try:
        result = subprocess.run(
            [parser_path],
            input=expr + "\n",
            capture_output=True,
            text=True
        )

        if result.returncode != 0:
            return Response({"error": result.stderr.strip()}, status=status.HTTP_400_BAD_REQUEST)

        return Response({"result": result.stdout.strip()})
    except FileNotFoundError:
        return Response({"error": "Parser executable not found"}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)