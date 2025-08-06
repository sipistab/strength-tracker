# StrengthTracker - Starting Strength Workout Assistant

A comprehensive, terminal-based workout tracking application for Mark Rippetoe's Starting Strength program. Tracks linear progression, manages deloads, calculates warmup sets, and maintains detailed workout history.

## Installation

### PyPI (Python Package Index)
```bash
pip install strength-tracker
```

### AUR (Arch User Repository)
```bash
# Using yay (recommended)
yay -S strength-tracker

# Using paru
paru -S strength-tracker

# Using pacman (if already in official repos)
sudo pacman -S strength-tracker
```

## Usage

Run the application:
```bash
python -m strength-tracker
```

Upon starting the program, it will check for existing workout data and current weights in your home directory (`~/.strength_tracker/`). If no previous data exists, it will initialize with default Starting Strength starting weights.

## Interface Examples

### Main Menu
```
=========================================
        StrengthTracker
    Starting Strength Program
=========================================

Choose an option:

1. Start Workout
2. View History  
3. View Progress
q. Quit

Enter your choice (1-3, or q): 
```

### Workout Day Check
```
Today is not a workout day.
Workout days: ['Tue', 'Thu', 'Sun']

Press Enter to continue...
```

### Starting a Workout
```
Today's workout: week_A
Exercises: squat, bench_press, deadlift, atlas_curl, neck_curl, hanging_leg_raise

Squat
Current weight: 60 kg

Warmup sets:
  1. 30 kg × 5
  2. 42 kg × 3
  3. 54 kg × 1

Working sets: 3 × 5

Set 1:
Weight (kg) [60]: 
Reps completed [5]: 
```

### Successful Set
```
Good set.
Increase weight by 2.5 kg? (y/n): y
Weight increased to 62.5 kg
```

### Failed Set
```
Failed set.
Deload 10% next time? (y/n): y
Weight reduced to 54 kg
```

### Progress View
```
Current Weights

┌─────────────────┬─────────────────┬─────────────────┬──────────┐
│ Exercise        │ Current Weight  │ Starting Weight │ Progress │
├─────────────────┼─────────────────┼─────────────────┼──────────┤
│ Squat           │ 62.5            │ 60              │ +2.5 kg  │
│ Bench Press     │ 50              │ 50              │ +0 kg    │
│ Overhead Press  │ 40              │ 40              │ +0 kg    │
│ Deadlift        │ 80              │ 80              │ +0 kg    │
│ Power Clean     │ 40              │ 40              │ +0 kg    │
│ Atlas Curl      │ bodyweight      │ bodyweight      │ N/A      │
│ Neck Curl       │ 5               │ 5               │ +0 kg    │
│ Hanging Leg     │ bodyweight      │ bodyweight      │ N/A      │
│ Raise           │                 │                 │          │
└─────────────────┴─────────────────┴─────────────────┴──────────┘
```

### History View
```
Workout History

┌────────────┬──────────┬─────────────────┬────────┐
│ Date       │ Workout  │ Exercises       │ Status │
├────────────┼──────────┼─────────────────┼────────┤
│ 2024-01-15 │ week_A   │ 6 exercises     │ ✓      │
│ 2024-01-11 │ week_B   │ 6 exercises     │ ✓      │
│ 2024-01-08 │ week_A   │ 6 exercises     │ ✓      │
└────────────┴──────────┴─────────────────┴────────┘
```

## Workout Schedule

Starting Strength follows a 3-day per week schedule:

- **Tuesday**: Week A or B workout
- **Thursday**: Week A or B workout  
- **Sunday**: Week A or B workout

The program automatically alternates between Week A and Week B workouts based on the current week number.

## Workout Structure

### Week A Workout
1. **Squat** (3×5) - +2.5 kg per workout
2. **Bench Press** (3×5) - +2.5 kg per workout
3. **Deadlift** (1×5) - +5 kg per workout

### Week B Workout
1. **Squat** (3×5) - +2.5 kg per workout
2. **Overhead Press** (3×5) - +2.5 kg per workout
3. **Power Clean** (5×3) - +2.5 kg per workout

### Bonus Exercises (Every Week)
4. **Atlas Curl** (2×10) - Bodyweight, no progression
5. **Neck Curl** (3×15) - Bodyweight, no progression
6. **Hanging Leg Raise** (3×10) - Bodyweight, no progression

## Weight Progression Rules

- **Squat**: +2.5 kg per successful workout
- **Bench Press**: +2.5 kg per successful workout
- **Overhead Press**: +2.5 kg per successful workout
- **Deadlift**: +5 kg per successful workout
- **Power Clean**: +2.5 kg per successful workout
- **Accessories**: Fixed weight or bodyweight (no progression)

## Deload Logic

When you fail to complete all reps in a working set:

1. **Automatic Tracking**: Failed sets are tracked per exercise
2. **Configurable Threshold**: After 3 consecutive failures (configurable), weight is automatically reduced by 10% (configurable)
3. **Deloaded Sets**: The application clearly indicates when you are performing a deloaded set
4. **Streak Reset**: Success resets the failure streak

## Warmup Calculations

The program automatically calculates warmup sets for main lifts:

- **50% of working weight** × 5 reps
- **70% of working weight** × 3 reps  
- **90% of working weight** × 1 rep

Accessory exercises (curls, leg raises) skip warmup sets.

## File Structure

```
strength_tracker/
├── strength_tracker/          # Package directory
│   ├── __init__.py           # Package initialization
│   └── strength_tracker.py   # Main application
├── config.yaml               # User configuration file
├── requirements.txt           # Python dependencies
├── README.md                 # This documentation
├── design.txt                # Development blueprint
├── run.py                    # Simple launcher script
├── pyproject.toml            # Package configuration
├── setup.py                  # Alternative setup script
├── MANIFEST.in               # Package manifest
├── LICENSE                   # MIT License
├── CHANGELOG.md              # Version history
├── PKGBUILD                  # AUR package build script
├── .SRCINFO                  # AUR package metadata
├── .aurignore                # AUR ignore file
├── .gitignore                # Git ignore file
├── scripts/                  # Helper scripts
│   └── update-aur.sh        # AUR update script
├── .github/workflows/        # CI/CD workflows
│   ├── test.yml             # Testing workflow
│   ├── release.yml          # PyPI release workflow
│   └── aur-release.yml      # AUR update workflow
└── ~/.strength_tracker/      # User data directory (auto-created)
    ├── workouts/             # Workout history
    │   ├── 2024_01_15.yaml
    │   ├── 2024_01_16.yaml
    │   └── ...
    ├── current_weights.yaml  # Current working weights
    └── failure_streaks.yaml  # Failure tracking per exercise
```

## Configuration

The program uses a comprehensive YAML configuration system. You can customize your workout program by editing `config.yaml` in the project directory.

### Config.yaml Structure

```yaml
# Program Settings
program:
  name: "Starting Strength Program"
  schedule:
    days: [2, 4, 7]  # Tuesday, Thursday, Sunday

# Exercise Definitions
exercises:
  squat:
    starting_weight: 60
    progression: 2.5
    sets: 3
    reps: 5
    description: "Back squat"

# Workout Templates
workouts:
  week_A:
    - squat
    - bench_press
    - deadlift
    
  week_B:
    - squat
    - overhead_press
    - power_clean

# Bonus Exercises (repeat every week regardless of A/B cycle)
bonus_exercises:
  - atlas_curl
  - neck_curl
  - hanging_leg_raise

# Deload Settings
deload:
  stalling_attempts: 3
  reduce_percent: 10

# Weight Rounding
rounding:
  increment: 2.5
  unit: "kg"
```

### Customization Options

- **Add New Exercises**: Define new exercises with starting weights, progression, sets, and reps
- **Modify Workouts**: Change which exercises are performed on each day
- **Adjust Deload Logic**: Configure how many failures trigger a deload and by what percentage
- **Change Weight Increments**: Modify the rounding increment (default: 2.5 kg)
- **Add Bonus Exercises**: Include exercises in the `bonus_exercises` section to repeat every week regardless of the A/B cycle

## Data Storage Format

### Workout Log Files (`workouts/YYYY_MM_DD.yaml`)

```yaml
date: "2024-01-15"
time: "14:30:25"
workout: "week_A"
exercises:
  squat:
    weight: 60
    sets:
      - set: 1
        weight: 60
        target_reps: 5
        actual_reps: 5
        failed: false
      - set: 2
        weight: 60
        target_reps: 5
        actual_reps: 5
        failed: false
      - set: 3
        weight: 60
        target_reps: 5
        actual_reps: 4
        failed: true
    completed: true
  bench_press:
    weight: 50
    sets:
      - set: 1
        weight: 50
        target_reps: 5
        actual_reps: 5
        failed: false
      # ... more sets
    completed: true
  # ... more exercises
```

### Current Weights File (`current_weights.yaml`)

```yaml
squat: 60
bench_press: 50
overhead_press: 40
deadlift: 80
power_clean: 40
atlas_curl: bodyweight
neck_curl: bodyweight
hanging_leg_raise: bodyweight
```

### Failure Streaks File (`failure_streaks.yaml`)

```yaml
squat: 0
bench_press: 2
overhead_press: 0
deadlift: 0
power_clean: 0
atlas_curl: 0
neck_curl: 0
hanging_leg_raise: 0
```

## Starting Weights

The program initializes with these Starting Strength recommended starting weights:

- **Squat**: 60 kg
- **Bench Press**: 50 kg
- **Overhead Press**: 40 kg
- **Deadlift**: 80 kg
- **Power Clean**: 40 kg
- **Accessories**: Bodyweight or minimal weight

## Features

- **Automatic Workout Scheduling**: Determines which workout is due based on the current week
- **Smart Workout Scheduling**: Tracks rest days and warns about overtraining while maintaining flexibility
- **Weight Progression**: Tracks and suggests weight increases after successful workouts
- **Automatic Deload**: Handles failed sets with configurable deload logic (3 failures = 10% reduction)
- **Weight Rounding**: Automatically rounds weights to nearest 2.5 kg increment
- **Warmup Calculations**: Automatically calculates appropriate warmup sets
- **Progress Tracking**: View your workout history and current weights
- **Local Data Storage**: All data stored in human-readable YAML format
- **Standalone Application**: No external dependencies or internet connection required

## The Starting Strength Program

This application implements Mark Rippetoe's Starting Strength program:

- **Linear Progression**: Add weight every workout until you can't
- **Compound Movements**: Focus on the big lifts (squat, press, deadlift)
- **Simple Programming**: No complex periodization or advanced techniques
- **Progressive Overload**: Gradually increase stress on the body
- **Novice-Friendly**: Designed for beginners to build strength quickly

The program is designed for beginners to build strength quickly through consistent, progressive training with proper form.

## Troubleshooting

**Q: The app says "Today is not a workout day"**
A: The program is flexible and allows workouts on any day. It will warn you if you worked out yesterday (recommending rest) or if you have completed many workouts this week, but will not block you from working out. Only one workout per day is allowed.

**Q: How do I change starting weights?**
A: Edit the `starting_weight` values in the `load_program()` method in `strength_tracker.py`.

**Q: Can I use different exercises?**
A: Yes, modify the `exercises` and `workouts` dictionaries in the `load_program()` method.

**Q: How do I reset my progress?**
A: Delete the `current_weights.yaml` file and the `workouts/` directory to start fresh.

**Q: Can I work out on different days?**
A: The program maintains the Starting Strength schedule. You can modify the `schedule` in the `load_program()` method.

## Dependencies

- `click` (>=8.0.0) - Command line interface
- `rich` (>=10.0.0) - Beautiful terminal output
- `pyyaml` (>=6.0.0) - YAML file handling

## Development

This is a standalone application designed to be:

- **Self-contained**: All functionality in one file
- **Portable**: Can be moved to any directory
- **Simple**: Easy to understand and modify
- **Focused**: Does one thing well - Starting Strength tracking

### Building from Source

```bash
# Clone the repository
git clone https://github.com/yourusername/strength-tracker.git
cd strength-tracker

# Install in development mode
pip install -e .

# Build the package
python -m build

# Install the built package
pip install dist/strength_tracker-1.0.0-py3-none-any.whl
```

### Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

### Releasing

To release a new version:

1. Update version in `pyproject.toml` and `setup.py`
2. Update `CHANGELOG.md`
3. Create and push a tag: `git tag v1.0.1 && git push origin v1.0.1`
4. GitHub Actions will automatically build and publish to PyPI and update AUR package

### AUR Package Maintenance

The AUR package is automatically updated when you release new versions. The workflow will:

1. Build the Python package
2. Calculate the SHA256 checksum
3. Update the PKGBUILD file with new version and checksum
4. Commit and push changes to the AUR repository

To manually update the AUR package:

```bash
# Update .SRCINFO file
makepkg --printsrcinfo > .SRCINFO

# Update PKGBUILD version and checksum
# Then commit and push to AUR
```

## License

Free to use, modify, and distribute as you see fit.