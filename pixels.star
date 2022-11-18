load("render.star", "render")
load("http.star", "http")
load("math.star", "math")

PIXELS_LEFT_URL = "http://localhost:4000/api/pixels_left"
TIDBYT_HEIGHT = 16
TIDBYT_WIDTH = 32


def render_circle(color):
    return render.Padding(
        child = render.Box(
            color = color,
            width = 1,
            height = 1,
        ),
        pad = (0, 1, 1, 0),
    )

def map(l, f):
    return [f(i) for i in l]


def main():
    rep = http.get(PIXELS_LEFT_URL)
    if rep.status_code != 200:
        fail("pixels left request failed with status %d", rep.status_code)

    response = rep.json()
    color = "no one"
    if response.get("data") != None:
        color = response["data"]["color"]
        count = int(response["data"]["count"])

    if count > TIDBYT_HEIGHT * TIDBYT_WIDTH:
        count = (TIDBYT_HEIGHT * TIDBYT_WIDTH) - 1
    screen = [["#000000" for x in range(TIDBYT_WIDTH)] for y in range(TIDBYT_HEIGHT)]
    for p in range(count):
        column_n = (p % TIDBYT_WIDTH)
        row_n = 0
        if (p % TIDBYT_WIDTH) == 0:
            row_n = int(p / TIDBYT_WIDTH)
        elif p > TIDBYT_WIDTH:
            row_n = math.ceil(p / TIDBYT_WIDTH) - 1
        screen[row_n][column_n] = color
    return render.Root(
            render.Column(
                children = map(
                    screen,
                    lambda status_row: render.Row(
                        children = map(status_row, lambda status: render_circle(status)),
                    ),
                ),
            ),
        delay = 500,
        )