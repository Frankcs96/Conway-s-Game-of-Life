<%@ page import="java.util.List" %>
<%@ page import="java.util.Arrays" %>
<%@ page import="java.lang.reflect.Array" %><%-- Created by IntelliJ IDEA. --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  final int BOARD_SIZE = 22;
  boolean[][] board = new boolean[BOARD_SIZE][BOARD_SIZE];

  for (int i = 0; i < board.length; i++) {
    for (int j = 0; j < board.length; j++) {
      String status = request.getParameter("checkbox" + (BOARD_SIZE * i + j));
      if (status != null) {
        board[i][j] = true;
      }
    }
  }
 board = nextStage(board);




%>
<html>
<head>
  <title>Conway's life game</title>
  <link rel="stylesheet" href="style.css">
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css" integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk" crossorigin="anonymous">
</head>
<body>
<div id="container">
<h1>Conway's Game of Life</h1>
<hr>

<br>


<form action="index.jsp" method="post">
  <button class="btn btn-danger"><a href="index.jsp" style="text-decoration: none; color: inherit">Reset</a></button>
  <input type="submit" value="Continue" class="btn btn-primary">
  <br>
  <br>
  <%
    for (int i = 0; i < board.length; i++) {
      for (int j = 0; j < board.length; j++) {
        if (board[i][j]) {
          out.print("<input type= \"checkbox\" name=\"checkbox" + (BOARD_SIZE * i + j)
                  + "\"value=\"true\" checked/>");

        } else {
          out.print("<input type= \"checkbox\" name=\"checkbox" + (BOARD_SIZE * i + j)
                  + "\"value=\"false\"/>");
        }

      }
      out.print("<br/>");
    }
  %>

</form>
</div>




<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js" integrity="sha384-OgVRvuATP1z7JjHLkuOU7Xw704+h835Lr+6QL9UvYjZE3Ipu6Tp75j7Bh/kR0JKI" crossorigin="anonymous"></script>
</body>
</html>


<%!
  //Devuelve numero de casillas vecinas vivas de una casilla en concreto.
  public int aliveNeighbours(int i, int j, boolean[][] board) {
    int result = 0;

    //Left
    if (j - 1 >= 0) {
      if (board[i][j - 1]) {
        result += 1;
      }
    }
    //right
    if (j + 1 < board.length) {
      if (board[i][j + 1]) {
        result += 1;
      }
    }

    //Up
    if (i - 1 >= 0) {
      if (board[i - 1][j]) {
        result += 1;
      }
    }
    //Down
    if (i + 1 < board.length) {
      if (board[i + 1][j]) {
        result += 1;
      }
    }

    //upper left diagonal
    if (i - 1 >= 0 && j - 1 >= 0) {
      if (board[i - 1][j - 1]) {
        result += 1;
      }
    }

    //upper right diagonal
    if ((i - 1 >= 0 && j + 1 < board.length)) {
      if (board[i - 1][j + 1]) {
        result += 1;
      }
    }
    // down left diagonal
    if (i + 1 < board.length && j - 1 >= 0) {
      if (board[i + 1][j - 1]) {
        result += 1;
      }
    }
    // down right diagonal
    if (i + 1 < board.length && j + 1 < board.length) {
      if (board[i + 1][j + 1]) {
        result += 1;
      }
    }

    return result;

  }

  public boolean[][] nextStage(boolean[][] board) {
    boolean[][] result = new boolean[board.length][board.length];
    for (int i = 0; i < board.length; i++) {
      for (int j = 0; j < board.length; j++) {
        if ((board[i][j] == false) && aliveNeighbours(i, j, board) == 3) {
          result[i][j] = true;
        }
        if ((board[i][j]) && (aliveNeighbours(i,j,board) == 2 || aliveNeighbours(i,j,board) == 3)) {
          result[i][j] = true;
        }
      }
    }
    return result;
  }

%>
