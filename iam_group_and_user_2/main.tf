resource "aws_iam_group" "groups" {
  name = each.value
  for_each = var.groups
}

resource "aws_iam_user" "users" {
  name = each.value
  for_each = var.users
}

resource "aws_iam_policy" "java" {
  name = "java_policy"
  description = "Policy for java developers"
  policy = "${file("s3-ro-policy.json")}"
}

resource "aws_iam_policy" "python" {
  name = "python_policy"
  description = "Policy for python developers"
  policy = "${file("ec2-ro-policy.json")}"
}

resource "aws_iam_policy" "C" {
  name = "C_Policy"
  description = "Policy for C developers"
  policy = "${file("ec2-start_stop_policy.json")}"
}

resource "aws_iam_group_policy_attachment" "java-attach" {
  group      = aws_iam_group.groups["java_dev"].name
  policy_arn = aws_iam_policy.java.arn
}

resource "aws_iam_group_policy_attachment" "python-attach" {
  group      = aws_iam_group.groups["python_dev"].name
  policy_arn = aws_iam_policy.python.arn
}

resource "aws_iam_group_policy_attachment" "C-attach" {
  group      = aws_iam_group.groups["C_dev"].name
  policy_arn = aws_iam_policy.C.arn
}

resource "aws_iam_group_membership" "grp-java" {
  name = "java-user-attach"
  users = [aws_iam_user.users["user_java"].name]
  group = aws_iam_group.groups["java_dev"].name
  
}

resource "aws_iam_group_membership" "grp-python" {
  name = "python-user-attach"
  users = [aws_iam_user.users["user_python"].name]
  group = aws_iam_group.groups["python_dev"].name
}

resource "aws_iam_group_membership" "grp-C" {
  name = "C-user-attach"
  users  = [aws_iam_user.users["user_C"].name]
  group = aws_iam_group.groups["C_dev"].name
}





