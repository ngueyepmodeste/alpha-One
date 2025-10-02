output "sg_bastion_id" {
  value = aws_security_group.bastion.id
}

output "sg_master_id" {
  value = aws_security_group.master.id
}

output "sg_worker_id" {
  value = {
    for k, sg in aws_security_group.worker :
    k => sg.id
  }
}

output "sg_alb_id" {
  value = aws_security_group.alb.id
}

output "sg_runner_id" {
  value = aws_security_group.runner.id
}

output "sg_vault_id" {
  value = [for sg in aws_security_group.vault : sg.id]
}