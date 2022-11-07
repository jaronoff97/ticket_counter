load("render.star", "render")
load("http.star", "http")

TICKET_COUNTER_PRICE_URL = "https://ticket-counter.fly.dev/api/current_ticket"


def main():
    rep = http.get(TICKET_COUNTER_PRICE_URL)
    if rep.status_code != 200:
        fail("Ticket counter request failed with status %d", rep.status_code)

    response = rep.json()["data"]
    name = response["name"]
    number = response["number"]
    print(str(number))
    print("{0} is next".format(name))
    return render.Root(
        child = render.Box( # This Box exists to provide vertical centering
            child = render.Animation(
                children = [
                    render.Row(
                        expanded=False, # Use as much horizontal space as possible
                        main_align="space_evenly", # Controls horizontal alignment
                        cross_align="center", # Controls vertical alignment
                        children = [
                            render.Text(content="#{0}.".format(str(int(number))), color="#3377FF", font="10x20"),
                            render.WrappedText("{0} is next".format(name), color="#FF650A", align="center"),
                        ],
                    ),
                    render.Row(
                        expanded=False, # Use as much horizontal space as possible
                        main_align="space_evenly", # Controls horizontal alignment
                        cross_align="center", # Controls vertical alignment
                        children = [
                            render.Text(content="#{0} ".format(str(int(number))), color="#3377FF", font="10x20"),
                            render.WrappedText("{0} is next".format(name), color="#FF650A", align="center"),
                        ],
                    ),
                ]
            )
        ),
        delay = 500,
    )