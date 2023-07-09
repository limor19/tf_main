resource "aws_scheduler_schedule" "stop_instance_in_time" {
  name = "my-schedule-stop"

  flexible_time_window {
    mode = "OFF"
  }
  schedule_expression = "cron(00 23 * * ? *)"

  target {
    arn      = "arn:aws:scheduler:::aws-sdk:ec2:stopInstances"
    role_arn = aws_iam_role.startinschedule.arn

    input = jsonencode(
      { "InstanceIds" : [aws_instance.ec2_limor.id] }
    )
  }
}
resource "aws_scheduler_schedule" "start_instance_in_time" {
  name = "my-schedule-start"

  flexible_time_window {
    mode = "OFF"
  }

  schedule_expression = "cron(00 5 * * ? *)"

  target {
    arn      = "arn:aws:scheduler:::aws-sdk:ec2:startInstances"
    role_arn = aws_iam_role.startinschedule.arn

    input = jsonencode(
      { "InstanceIds" : [aws_instance.ec2_limor.id] }
    )
  }
}