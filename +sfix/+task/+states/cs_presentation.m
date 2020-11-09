function state = cs_presentation(program, conf)

state = ptb.State();
state.Name = 'cs_presentation';
state.Duration = conf.TIMINGS.time_in.cs_presentation;

state.Entry = @(state) entry(state, program);
state.Exit = @(state) exit(state, program);

end

function entry(state, program)

data = sfix.util.data_this_trial( program );
data.event_times.cs_presentation.entry = elapsed( program.Value.task );

cue_label = sfix.util.cue_name_from_reward_size_label( data.conditioned_reward_size_label );

cue = program.Value.stimuli.(cue_label);
draw( cue, program.Value.window );
flip( program.Value.window );

data.event_times.cs_presentation.cs_onset = elapsed( program.Value.task );

end

function exit(state, program)

next( state, program.Value.states('cs_delay') );

end