static final int MARGIN_GAP = 15;
static final color WHITE = #ffffff;
static final color BLACK = #000000;

static final int CONTAINER_WIDTH = 870;
static final int CONTAINER_HEIGHT = 945;
static final int CONTAINER_OFFSET_Y = MARGIN_GAP;
static final int CONTAINER_OFFSET_X_BF = MARGIN_GAP;
static final int CONTAINER_OFFSET_X_GA = CONTAINER_OFFSET_X_BF + CONTAINER_WIDTH + MARGIN_GAP;
static final color CONTAINER_COLOR = #cccccc;

static final int TITLE_BOX_WIDTH = CONTAINER_WIDTH - 2 * MARGIN_GAP;
static final int TITLE_BOX_HEIGHT = 5 * MARGIN_GAP;
static final int TITLE_BOX_OFFSET_Y = CONTAINER_OFFSET_Y + MARGIN_GAP;
static final int TITLE_BOX_OFFSET_X_BF = CONTAINER_OFFSET_X_BF + MARGIN_GAP;
static final int TITLE_BOX_OFFSET_X_GA = CONTAINER_OFFSET_X_GA + MARGIN_GAP;

static final int BOARD_WIDTH = 450;
static final int BOARD_HEIGHT = 400;
static final int UPPER_BOARD_OFFSET_Y = TITLE_BOX_OFFSET_Y + TITLE_BOX_HEIGHT + MARGIN_GAP;
static final int LOWER_BOARD_OFFSET_Y = UPPER_BOARD_OFFSET_Y + BOARD_HEIGHT + MARGIN_GAP;
static final int BOARD_OFFSET_X_BF = CONTAINER_OFFSET_X_BF + MARGIN_GAP;

static final int STATS_WIDTH = CONTAINER_WIDTH - BOARD_WIDTH - 3 * MARGIN_GAP;
static final int STATS_HEIGHT = BOARD_HEIGHT;
static final int STATS_OFFSET_Y = UPPER_BOARD_OFFSET_Y;
static final int STATS_OFFSET_X_BF = BOARD_OFFSET_X_BF + BOARD_WIDTH + MARGIN_GAP;
static final int STATS_OFFSET_X_GA = CONTAINER_OFFSET_X_GA + MARGIN_GAP;

static final int BOARD_OFFSET_X_GA = STATS_OFFSET_X_GA + STATS_WIDTH + MARGIN_GAP;;

static final int BUTTON_HEIGHT = 50;
static final int LOCAL_BUTTON_WIDTH = STATS_WIDTH;
static final int START_BUTTON_OFFSET_Y = LOWER_BOARD_OFFSET_Y;
static final int IMPORT_BUTTON_OFFSET_Y = 10 + START_BUTTON_OFFSET_Y + BUTTON_HEIGHT;
static final int BUTTON_OFFSET_X_BF = MARGIN_GAP + BOARD_OFFSET_X_BF + BOARD_WIDTH;
static final int BUTTON_OFFSET_X_GA = CONTAINER_OFFSET_X_GA + MARGIN_GAP;

static final int GLOBAL_BUTTON_WIDTH = 300 + MARGIN_GAP;
static final int GLOBAL_BUTTON_OFFSET_X =
    CONTAINER_OFFSET_X_GA - (MARGIN_GAP + GLOBAL_BUTTON_WIDTH) / 2;
static final int RESET_BUTTON_OFFSET_Y = CONTAINER_HEIGHT + CONTAINER_OFFSET_Y - BUTTON_HEIGHT;
static final int STOP_BUTTON_OFFSET_Y = RESET_BUTTON_OFFSET_Y - BUTTON_HEIGHT;

AlgoBox bf;
AlgoBox ga;

TextBox stopButton;
TextBox resetButton;

void setup() {
  size(1800, 1000);

  Rectangle containerBF =
      new Rectangle(
          CONTAINER_OFFSET_X_BF,
          CONTAINER_OFFSET_Y,
          CONTAINER_WIDTH,
          CONTAINER_HEIGHT,
          CONTAINER_COLOR);
  Rectangle containerGA =
      new Rectangle(
          CONTAINER_OFFSET_X_GA,
          CONTAINER_OFFSET_Y,
          CONTAINER_WIDTH,
          CONTAINER_HEIGHT,
          CONTAINER_COLOR);

  TextBox titleBoxBF =
      new TextBox(
          TITLE_BOX_OFFSET_X_BF,
          TITLE_BOX_OFFSET_Y,
          TITLE_BOX_WIDTH,
          TITLE_BOX_HEIGHT,
          WHITE,
          "Brute Force Algorithm",
          BLACK);
  TextBox titleBoxGA =
      new TextBox(
          TITLE_BOX_OFFSET_X_GA,
          TITLE_BOX_OFFSET_Y,
          TITLE_BOX_WIDTH,
          TITLE_BOX_HEIGHT,
          WHITE,
          "Genetic Algorithm",
          BLACK);
  titleBoxBF.textSize = 24;
  titleBoxGA.textSize = 24;

  Rectangle upperBoardBF =
      new Rectangle(BOARD_OFFSET_X_BF, UPPER_BOARD_OFFSET_Y, BOARD_WIDTH, BOARD_HEIGHT, BLACK);
  Rectangle lowerBoardBF =
      new Rectangle(BOARD_OFFSET_X_BF, LOWER_BOARD_OFFSET_Y, BOARD_WIDTH, BOARD_HEIGHT, BLACK);

  Rectangle upperBoardGA =
      new Rectangle(BOARD_OFFSET_X_GA, UPPER_BOARD_OFFSET_Y, BOARD_WIDTH, BOARD_HEIGHT, BLACK);
  Rectangle lowerBoardGA =
      new Rectangle(BOARD_OFFSET_X_GA, LOWER_BOARD_OFFSET_Y, BOARD_WIDTH, BOARD_HEIGHT, BLACK);

  TextBox statsBF =
      new TextBox(STATS_OFFSET_X_BF, STATS_OFFSET_Y, STATS_WIDTH, STATS_HEIGHT, BLACK, WHITE);
  TextBox statsGA =
      new TextBox(STATS_OFFSET_X_GA, STATS_OFFSET_Y, STATS_WIDTH, STATS_HEIGHT, BLACK, WHITE);

  TextBox startButtonBF =
      new TextBox(
          BUTTON_OFFSET_X_BF,
          START_BUTTON_OFFSET_Y,
          LOCAL_BUTTON_WIDTH,
          BUTTON_HEIGHT,
          WHITE,
          "Start",
          BLACK);
  TextBox importButtonBF =
      new TextBox(
          BUTTON_OFFSET_X_BF,
          IMPORT_BUTTON_OFFSET_Y,
          LOCAL_BUTTON_WIDTH,
          BUTTON_HEIGHT,
          WHITE,
          "Import Points",
          BLACK);

  TextBox startButtonGA =
      new TextBox(
          BUTTON_OFFSET_X_GA,
          START_BUTTON_OFFSET_Y,
          LOCAL_BUTTON_WIDTH,
          BUTTON_HEIGHT,
          WHITE,
          "Start",
          BLACK);
  TextBox importButtonGA =
      new TextBox(
          BUTTON_OFFSET_X_GA,
          IMPORT_BUTTON_OFFSET_Y,
          LOCAL_BUTTON_WIDTH,
          BUTTON_HEIGHT,
          WHITE,
          "Import Points",
          BLACK);

  bf =
      new BF(
          containerBF,
          titleBoxBF,
          upperBoardBF,
          lowerBoardBF,
          statsBF,
          startButtonBF,
          importButtonBF);
  ga =
      new GA(
          containerGA,
          titleBoxGA,
          upperBoardGA,
          lowerBoardGA,
          statsGA,
          startButtonGA,
          importButtonGA);

  stopButton =
      new TextBox(
          GLOBAL_BUTTON_OFFSET_X,
          STOP_BUTTON_OFFSET_Y,
          GLOBAL_BUTTON_WIDTH,
          BUTTON_HEIGHT,
          WHITE,
          "Stop",
          BLACK);
  resetButton =
      new TextBox(
          GLOBAL_BUTTON_OFFSET_X,
          RESET_BUTTON_OFFSET_Y,
          GLOBAL_BUTTON_WIDTH,
          BUTTON_HEIGHT,
          WHITE,
          "Reset",
          BLACK);
}

void draw() {
  background(250);

  bf.draw();
  ga.draw();

  stopButton.draw();
  resetButton.draw();

  if (bf.isActive) {
    bf.run();
  }
  if (ga.isActive) {
    ga.run();
  }
}

void mousePressed() {
  if (stopButton.isMouseOver()) {
    bf.stop();
    ga.stop();
  } else if (resetButton.isMouseOver()) {
    bf.reset();
    ga.reset();
  } else if (!ga.isActive && !bf.isActive) {
    bf.mousePressedMayBe(ga.points, ga.upperBoard.x);
    ga.mousePressedMayBe(bf.points, bf.upperBoard.x);
  }
}
