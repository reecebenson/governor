# TODO: Make this more prefix-agnostic
def strip_prefix(mes):
    return mes[1:]

# Returns the first word of a string
def get_command(mes):
    words = mes.split()
    return words[0]

# Removes the "!command" to get just the request
def remove_command(mes):
    request = mes.split()[1:]
    return " ".join(request)