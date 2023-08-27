Function myMethod()
    Dim i As Integer
    If (test()) Then
      i = 10
    End If

    If i = 0 Then Return False Else Return True

End Function
Private Function test() As Boolean
    Return true
End Function