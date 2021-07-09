resource "aws_iam_group" "group_create" {
  name = each.value
  for_each = var.groups
}

resource "aws_iam_policy" "policy_group_dev" {
  name = "dev_policy"
  description = "S3 full access to dev group"
  policy = "${file("s3-full-policy.json")}"
}

resource "aws_iam_policy" "policy_group_prod" {
  name  = "prod_policy"
  description = "S3 read only access to prod group"
  policy = "${file("s3-ro-policy.json")}"
}

resource "aws_iam_group_policy_attachment" "dev-attach" {
  group = aws_iam_group.group_create["dev"].name
  policy_arn = aws_iam_policy.policy_group_dev.arn
}

resource "aws_iam_group_policy_attachment" "prod-attach" {
  group = aws_iam_group.group_create["prod"].name
  policy_arn = aws_iam_policy.policy_group_prod.arn
}

resource "aws_iam_user" "dev_user" {
  name = each.value
  for_each = var.dev_user
}

resource "aws_iam_user" "prod_user" {
  name = each.value
  for_each = var.prod_user
}

resource "aws_iam_group_membership" "dev_membership" {
  name = "dev_user_attach_to_dev_group"
  users = [aws_iam_user.dev_user[each.value].name]
  for_each = var.dev_user
  group = aws_iam_group.group_create["dev"].name
}

resource "aws_iam_group_membership" "prod_membership" {
 name = "prod_user_attach_to_prod_group"
 users = [aws_iam_user.prod_user[each.value].name]
 for_each = var.prod_user
 group = aws_iam_group.group_create["prod"].name
}
