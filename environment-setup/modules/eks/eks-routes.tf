resource "aws_route_table_association" "private-eks-subnet-a-assoc" {
  subnet_id      = aws_subnet.private-eks-subnet-a.id
  route_table_id = var.private-route-table-id
}

resource "aws_route_table_association" "private-eks-subnet-b-assoc" {
  subnet_id      = aws_subnet.private-eks-subnet-b.id
  route_table_id = var.private-route-table-id
}

resource "aws_route_table_association" "public-eks-subnet-a-assoc" {
  subnet_id      = aws_subnet.public-eks-subnet-a.id
  route_table_id = var.public-route-table-id
}

resource "aws_route_table_association" "public-eks-subnet-b-assoc" {
  subnet_id      = aws_subnet.public-eks-subnet-b.id
  route_table_id = var.public-route-table-id
}
