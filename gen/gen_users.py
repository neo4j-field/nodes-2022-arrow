#!/usr/bin/env python3
from random import uniform

words = []
with open('./wordlist.txt', mode='r') as f:
	line = f.readline()
	while line:
		words.append(line.strip())
		line = f.readline()


def gen(n: int, cypher, csv):
	password = '-'.join(
		[words[int(uniform(0, len(words)))] for _ in range(1, 4)]
	)
	username = f"user{format(n, '03d')}"
	cypher.write(f":param user =>'{username}'\n")
	cypher.write(f":param role =>'{username}role'\n")
	cypher.write(f":param homedb =>'{username}'\n")
	cypher.write(f":param password =>'{password}'\n")
	cypher.write(":source rbac.cypher\n")
	csv.write(f"{username},{password}\n")


with open('./gen.cypher', mode='w') as cypher:
	with open('./gen.csv', mode='w') as csv:
			for n in range(1, 41):
				gen(n, cypher, csv)
